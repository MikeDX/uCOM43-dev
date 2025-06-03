from rom import rom
gosub_calls = {}
tickcount = 0
page = -1
docomments = True

def dotick():
    global tickcount

    if tickcount > 0:
        ret = f"""
        ticks+={tickcount};
        """
        tickcount = 0

    else:
    
        ret = ""

    
    return ret

def next_op(next):
    ret = f"""
        goto l{next['addr']:04x};"""
    return ret
def op_nop(r,next):
    return """
    // NOP: No Operation
    """

def op_di(r,next):
    return """
    // DI: Reset Interrupt Enable F/F
    """
def op_s(r,next):
    return """
    // S: Store ACC into RAM
    ram_w(cpu.acc);
    
    """
def op_tit(r,next):
    return """
    // TIT: skip next on Interrupt
    // astro wars doesnt use interrupts
    //
    // do nothing;
    
    """

def op_tc(r,next):
    return f"""
    // TC: skip next on Carry F/F
    // cpu.skip = (cpu.carry_f != 0);
    {dotick()}
    if (cpu.carry_f) {{{next_op(next)}
    }}
    """

def op_ttm(r,next):
    return f"""
    // TTM: skip next on Timer F/F
    // cpu.skip = (cpu.timer_f != 0);
    {dotick()}
    if (cpu.timer_f) {{{next_op(next)}
    }}
    """

def op_daa(r,next):
    return """
    // DAA: Add 6 to ACC to adjust decimal for BCD Addition
    cpu.acc = (cpu.acc + 6) & 0xf;
    // cpu.acc += 6 ; //(cpu.acc + 6) & 0xf;    
    """

def op_tal(r,next):
    return """
    // TAL: Transfer ACC to DPl
    cpu.dpl = cpu.acc;    
    """

def op_ad(r,next):
    return f"""
    // AD: Add RAM to ACC, skip next on carry
    // printf("Acc: %d\\n", cpu.acc);
    // printf("ram: %d\\n", ram_r());
    cpu.acc += ram_r();
    // printf("New acc: %d\\n", cpu.acc);

    // cpu.skip = ((cpu.acc & 0x10) != 0);
    // printf("Skip: %d\\n", cpu.skip);
    if (cpu.acc & 0x10) {{
        cpu.acc &= 0xf;
        {dotick()}
    //    printf("New acc: %d\\n", cpu.acc);{next_op(next)}
    }}
    """

def op_ads(r,next):
    res = op_adc(r,next);
    res += f"""
	// ADS: Add RAM and carry to ACC, 
    {dotick()}
    // store Carry F/F, skip next on carry
    if (cpu.carry_f) {{{next_op(next)}
    }}
    """

    return res

def op_das(r,next):
    return """
	// DAS: Add 10 to ACC to adjust decimal for BCD Subtraction
	cpu.acc = (cpu.acc + 10) & 0xf;
    """

def op_clc(r,next):
    return """
    // CLC: Reset Carry F/F
    cpu.carry_f = 0;    
    """

def op_cm(r,next):
    return f"""
    // CM: skip next on ACC equals RAM
    //cpu.skip = (cpu.acc == ram_r());
    //if (cpu.skip) {{
        {dotick()}
    if (cpu.acc == ram_r()) {{{next_op(next)}
    }}
    """

def op_inc(r,next):
    return f"""
    // INC: Increment ACC, skip next on carry
    cpu.acc = (cpu.acc + 1) & 0xf;
    // cpu.skip = (cpu.acc == 0);
    {dotick()}
    if (cpu.acc == 0) {{{next_op(next)}
    }}

    """

def op_op(r,next):
    return f"""
    // OP: Output ACC to port (DPl)
    // printf("opop [%04X], writing %d to NEC_UCOM4_PORT%c\\n", {r['addr']}, cpu.acc, 'A'+cpu.dpl);
    output_w(cpu.dpl, cpu.acc);    
    """

def op_dec(r,next):
    return f"""
    // DEC: Decrement ACC, skip next on carry
    cpu.acc = (cpu.acc - 1) & 0xf;
    // cpu.skip = (cpu.acc == 0xf);
    {dotick()}
    if (cpu.acc == 0xf) {{{next_op(next)}
    }}

    """

def op_cma(r,next):
    return """
    // CMA: Complement ACC
    cpu.acc ^= 0xf;
    
    """

def op_cia(r,next):
    return """
	// CIA: Complement ACC, Increment ACC
	cpu.acc = ((cpu.acc ^ 0xf) + 1) & 0xf;    
    """

def op_tla(r,next):
    return """
	// TLA: Transfer DPl to ACC
	cpu.acc = cpu.dpl;    
    """

def op_ded(r,next):
    return f"""
    // DED: Decrement DPl, skip next on carry
    cpu.dpl = (cpu.dpl - 1) & 0xf;
    // cpu.skip = (cpu.dpl == 0xf);    
    {dotick()}
    if (cpu.dpl == 0xf) {{{next_op(next)}
    }}

    """

def op_stm(r,next):
    timer = (((r['arg'] + 1) & 0x3f) * 63)
    return f"""
    // STM X: Reset Timer F/F, Start Timer with X
    cpu.timer_f = 0;
    // printf("Set timer to {timer} ticks. Remain ticks: %d\\n", ticks);
    timer = {timer};    
    """

def op_ldi(r,next):
    arg = r['arg'] >> 4 & 0xf
    arg2 = r['arg'] & 0x0f
    return f"""
    // LDI X: Load DP with X
    cpu.dp = {r['arg']};
//    cpu.dph = {arg};
//    cpu.dpl = {arg2};
    """

def op_cli(r,next):
    arg = r['arg'] & 0x0f
    return f"""
    // CLI X: skip next on DPl equals X
    // cpu.skip = (cpu.dpl == {arg});    
    {dotick()}
    if (cpu.dpl == {arg}) {{{next_op(next)}
    }}
    """

def op_ci(r,next):
    return f"""
    // CI X: skip next on ACC equals X
    // cpu.skip = (cpu.acc == ({r['arg']} & 0x0f));   
    {dotick()} 
    if (cpu.acc == 0x{r['arg']:02x}) {{{next_op(next)}
    }}
    """

def op_exl(r,next):
    return """
    // EXL: Xor ACC with RAM
    cpu.acc ^= ram_r();    
    """

def op_adc(r,next):
    return """
    // ADC: Add RAM and carry to ACC, store Carry F/F
    cpu.acc += ram_r() + cpu.carry_f;
    cpu.carry_f = (cpu.acc >> 4) & 1;
    cpu.acc &= 0xf;   
    """
def op_xc(r,next):
    return """
    // XC: Exchange Carry F/F with Carry Save F/F
    exc = cpu.carry_f;
    cpu.carry_f = cpu.carry_s_f;
    cpu.carry_s_f = exc;
    """

def op_stc(r,next):
    return """
    // STC: Set Carry F/F
    cpu.carry_f = 1;
    """

def op_illegal(r,next):
    return """
    // do nothing;
    
    """

def op_inm(r,next):
    return f"""
    // INM: Increment RAM, skip next on carry
    val = (ram_r() + 1) & 0xf;
    ram_w(val);
    //cpu.skip = (val == 0);
    {dotick()}
    if (val == 0) {{{next_op(next)}
    }}
    """

def op_ocd(r,next):
    argl4 = (r['arg']) >> 4
    argh4 = (r['arg']) & 0x0f
    return f"""
    // OCD X: Output X to ports C and D
    output_w(NEC_UCOM4_PORTD, {argl4});
    output_w(NEC_UCOM4_PORTC, {argh4});    
    """

def op_dem(r,next):
    return f"""
    // DEM: Decrement RAM, skip next on carry
    val = (ram_r() - 1) & 0xf;
    ram_w(val);
    // cpu.skip = (val == 0xf);
    {dotick()}
    if (val == 0xf) {{{next_op(next)}
    }}
    """

def op_fbf(r,next):
    return f"""
    // FBF B: skip next on NOT bit(FLAG)
    // cpu.skip = ((ucom43_reg_r(UCOM43_F) & {r['bitmask']}) == 0);
    {dotick()}
    if ((ucom43_reg_r(UCOM43_F) & {r['bitmask']}) == 0) {{{next_op(next)}
    }}
    """
def op_tab(r,next):
    return f"""
    // TAB B: skip next on bit(ACC)
    // cpu.skip = ((cpu.acc & {r['bitmask']}) != 0);
    {dotick()}
    if ((cpu.acc & {r['bitmask']}) != 0) {{{next_op(next)}
    }}
    """

def op_xm(r,next):

#     // X: used 4 times (with no arg)
#     // XM: used 21 times
# 	// XM X: Exchange ACC with RAM, xor DPh with X
    if "arg" not in r:
        r['arg'] = 0
    op = r['arg'] & 0x03
    ret =  """
    // XM X: Exchange ACC with RAM, xor DPh with X
    old_acc = cpu.acc;
    cpu.acc = ram_r();
    ram_w(old_acc);
    """
    if op != 0:
        ret = ret + f"""
    cpu.dph ^= {op};
    """
        
    return ret

def op_xmd(r,next):
    # op_xm();
	# cpu.dpl = (cpu.dpl - 1) & 0xf;
	# cpu.skip = (cpu.dpl == 0xf);

    res = op_xm(r,next)

    return res + f"""
    // XMD X: Exchange ACC with RAM, xor DPh with X, Decrement DPl, skip next on carry
	cpu.dpl = (cpu.dpl - 1) & 0xf;

//    cpu.dpl--;// = (cpu.dpl - 1) & 0xf;
//    cpu.skip = (cpu.dpl == 0xf);  
{dotick()}
    if (cpu.dpl == 0xf) {{{next_op(next)}
    }}

    """

def op_rar(r,next):
    return """
	// RAR: Rotate ACC Right through Carry F/F
	old_acc = cpu.acc & 1;
	cpu.acc = cpu.acc >> 1 | cpu.carry_f << 3;
	cpu.carry_f = old_acc;
    """

def op_ei(r,next):
    return """
    // EI: Set Interrupt Enable F/F
	cpu.inte_f = 1;
    """

def op_ip(r,next):
    return """
    // IP: Input port (DPl) to ACC
    cpu.acc = input_r(cpu.dpl);    
    """

def op_ind(r,next):
    return f"""
    // IND: Increment DPl, skip next on carry
    cpu.dpl = (cpu.dpl + 1) & 0xf;
    // cpu.dpl++;// = (cpu.dpl + 1) & 0xf;
    //cpu.skip = (cpu.dpl == 0);    
    {dotick()}
    if(cpu.dpl == 0) {{{next_op(next)}
    }}
    """

def op_cmb(r,next):
    return """
    // CMB B: skip next on bit(ACC) equals bit(RAM)
    
	cpu.skip = ((cpu.acc & {r['bitm
    {dotick()}ask']}) == (ram_r() & {r['bitmask']}));
    if (cpu.skip) {{{next_op(next)}
    }}
    """

def op_lm(r,next):
    if 'arg' not in r:
        r['arg'] = 0
    op = r['arg'] & 0x03
    return f"""
    // LM X: Load ACC with RAM, xor DPh with X
    cpu.acc = ram_r();
    // not needed for 'L'
    cpu.dph ^= {op};    
    """
def op_xmi(r,next):
    res = op_xm(r,next)
    return res + f"""
    // XMI X: Exchange ACC with RAM, xor DPh with X, Increment DPl, skip next on carry
	cpu.dpl = (cpu.dpl + 1) & 0xf;
	// cpu.skip = (cpu.dpl == 0);
    {dotick()}
    if (cpu.dpl == 0) {{{next_op(next)}
    }}

    """
def op_ia(r,next):
    return """
    // IA: do nothing;
    
    """
def op_jpa(r,next):
    pc = r['addr'] & ~0x3f
    addr = []
    for i in range(16):
        addr.append(pc | i << 2)

    res = """
    // JPA: Jump to (ACC) in current page
    switch(cpu.acc) {{
    """

    for i, add in enumerate(addr):
        if add != 0x07e0:
            res += f"""
            case {i}:
                goto l{add:04x};
                break;
            """
    res += """
        default:
            break;
    }}
    """

    return res

def op_taz(r,next):
    return """
	// TAZ: Transfer ACC to Z
	ucom43_reg_w(UCOM43_Z, cpu.acc);    
    """
def op_taw(r,next):
    return """
    // TAW: Transfer ACC to W
    ucom43_reg_w(UCOM43_W, cpu.acc);
    """
def op_oe(r,next):
    return """
    // OE: Output ACC to port E
    output_w(NEC_UCOM4_PORTE, cpu.acc);    
    """
def op_tly(r,next):
    return """
	// TLY: Transfer DPl to Y
	ucom43_reg_w(UCOM43_Y, cpu.dpl);    
    """
def op_thx(r,next):
    return """
	// THX: Transfer DPh to X
	ucom43_reg_w(UCOM43_X, cpu.dph);    
    """
def op_rt(r,next):
    return """
    // op_rt
    return (0);
    
    """

def op_rts(r,next):
    return """
    // RTS: Return from subroutine, skip next
    return (1);
    """
def op_xaz(r,next):
    return """
	// XAZ: Exchange ACC with Z
	old_acc = cpu.acc;
	cpu.acc = ucom43_reg_r(UCOM43_Z);
	ucom43_reg_w(UCOM43_Z, old_acc);    
    """

def op_xaw(r,next):
    return """
    // XAW: Exchange ACC with W
    old_acc = cpu.acc;
    cpu.acc = ucom43_reg_r(UCOM43_W);
    ucom43_reg_w(UCOM43_W, old_acc);    
    """
def op_xls(r,next):
    return """
    // do nothing;
    
    """
def op_xhr(r,next):
    return """
    // do nothing;
    
    """

def op_xly(r,next):
    return """
    // XLY: Exchange DPl with Y
    old_dpl = cpu.dpl;
    cpu.dpl = ucom43_reg_r(UCOM43_Y);
    ucom43_reg_w(UCOM43_Y, old_dpl);
    """
def op_xhx(r,next):
    return """
    // XHX: Exchange DPh with X
    old_dph = cpu.dph;
    cpu.dph = ucom43_reg_r(UCOM43_X);
    ucom43_reg_w(UCOM43_X, old_dph);    
    """
def op_tpb(r,next):
    return f"""
    // TPB B: skip next on bit(input port (DPl))
    // cpu.skip = ((input_r(cpu.dpl) & {r['bitmask']}) != 0);    
    {dotick()}
    if ((input_r(cpu.dpl) & {r['bitmask']}) != 0) {{{next_op(next)}
    }}
    """

def op_tpa(r,next):
    return f"""
    // TPA B: skip next on bit(input port A)
    // cpu.skip = ((input_r(NEC_UCOM4_PORTA) & cpu.bitmask) != 0);
    {dotick()}
    if ((input_r(NEC_UCOM4_PORTA) & {r['bitmask']})!= 0) {{{next_op(next)}
    }}
    """
def op_tmb(r,next):
    return f"""
    // TMB B: skip next on bit(RAM)
    // cpu.skip = (((ram_r() & {r['bitmask']}) != 0);
    {dotick()}
    if (((ram_r() & {r['bitmask']}) != 0)) {{{next_op(next)}
    }}
    """
def op_fbt(r,next):
    return f"""
    // FBT B: skip next on bit(FLAG)
//    cpu.skip = ((ucom43_reg_r(UCOM43_F) & {r['bitmask']}) != 0);
{dotick()}
    if ((ucom43_reg_r(UCOM43_F) & {r['bitmask']}) != 0) {{{next_op(next)}
    }}
    """
def op_rpb(r,next):
    return """
    // do nothing;
    
    """
def op_reb(r,next):
    return f"""
    // REB B: Reset a single bit of output port E
    output_w(NEC_UCOM4_PORTE, cpu.port_out[NEC_UCOM4_PORTE] & ~{r['bitmask']});    
    """
def op_rmb(r,next):
    return f"""
    // RMB B: Reset a single bit of RAM
    ram_w(ram_r() & ~{r['bitmask']});

    
    """
def op_rfb(r,next):
    return f"""
	// RFB B: Reset a single bit of FLAG
    ucom43_reg_w(UCOM43_F, ucom43_reg_r(UCOM43_F) & ~{r['bitmask']});
    
    """
def op_spb(r,next):
    return """
    // do nothing;
    
    """
def op_seb(r,next):
    return f"""
    // SEB B: Set a single bit of output port E
    output_w(NEC_UCOM4_PORTE, cpu.port_out[NEC_UCOM4_PORTE] | {r['bitmask']});    
    """
def op_smb(r,next):
    return f"""
    // SMB B: Set a single bit of RAM
    ram_w(ram_r() | {r['bitmask']});    
    """
def op_sfb(r,next):
    return f"""
    // SFB B: Set a single bit of FLAG
    ucom43_reg_w(UCOM43_F, ucom43_reg_r(UCOM43_F) | {r['bitmask']});
    """

def op_ldz(r,next):
    arg = r['arg'] & 0x0f;
    return f"""
    // LDZ X: Load DPh with 0, Load DPl with X
//    cpu.dph = 0;
//    cpu.dpl = {r['arg']};
    cpu.dp = {arg};
    """

def op_li(r,next):
    if 'arg' not in r:
        r['arg'] = 0;
    return f"""
    // LI X: Load ACC with X
    // note: only execute the first one in a sequence of LI
    cpu.acc = 0x{r['arg']:02x};
    goto l{(next['addr']):04x};
    """

def op_jmpcal(r,next):
    if (int(r['opnem'],16) & 0x08):

        return "//JMPCAL \n//CAL: \n" + op_cal(r,next)
    else:
        return "//JMPCAL \n//JMP: \n" + op_jmp(r,next)

def op_cal(r,next):
    return f"""
    // CAL A: Call Address
    {dotick()}
    if (astro_loop(0x{r['arg']:04x})) {{{next_op(next)}
    }}
    """

def op_jmp(r,next):
    return f"""
    // JMP A: Jump to Address
    goto l{r['arg']:04x};
    """

def op_czp(r,next):
    return f"""
    // CZP A: Call Address (short)
    {dotick()}
    if (astro_loop(0x00{(r['arg'] << 2):02X})) {{{next_op(next)}
    }}
   
    """

def op_jcp(r,next):

    pc = r['addr']
    pc = (pc & ~0x3f) | (r['arg'] & 0x3f)
    # print(f"{pc:03x}")
    return f"""
    // JCP A: Jump to Address in current page
    goto l{pc:04x};
    
    """

opcode_table = [
    op_nop, op_di, op_s, op_tit, op_tc, op_ttm, op_daa, op_tal, # 0x07
    op_ad, op_ads, op_das, op_clc, op_cm, op_inc, op_op, op_dec, # 0x0f
    op_cma, op_cia, op_tla, op_ded, op_stm, op_ldi, op_cli, op_ci, # 0x17
    op_exl, op_adc, op_xc, op_stc, op_illegal, op_inm, op_ocd, op_dem, # 0x1f

    # op & 0xfc
    # 0x20
    op_fbf, op_fbf, op_fbf, op_fbf,
    # 0x24
    op_tab, op_tab, op_tab, op_tab, # 0x27

    # 0x28
    op_xm, op_xm, op_xm, op_xm, 
    
    #0x2c
    op_xmd, op_xmd, op_xmd, op_xmd, # 0x2f

    # 0x30
    op_rar, op_ei, op_ip, op_ind, 
    
    # op & 0xfc
    # 0x34
    op_cmb, op_cmb, op_cmb, op_cmb, # 0x37
    # 0x38
    op_lm, op_lm, op_lm, op_lm, 
    # 0x3c
    op_xmi, op_xmi, op_xmi, op_xmi, # 0x3f

    # 0x40
    op_ia, op_jpa, op_taz, op_taw, op_oe, op_illegal, op_tly, op_thx, # 0x47
    # 0x48
    op_rt, op_rts, op_xaz, op_xaw, op_xls, op_xhr, op_xly, op_xhx, # 0x4f

    # op & 0xfc

    # 0x50
    op_tpb, op_tpb, op_tpb, op_tpb, 
    # 0x54 
    op_tpa, op_tpa, op_tpa, op_tpa, # 0x57
    # 0x58
    op_tmb, op_tmb, op_tmb, op_tmb, 
    # 0x5c
    op_fbt, op_fbt, op_fbt, op_fbt, # 0x5f
    # 0x60
    op_rpb, op_rpb, op_rpb, op_rpb, 
    # 0x64 
    op_reb, op_reb, op_reb, op_reb, # 0x67
    # 0x68
    op_rmb, op_rmb, op_rmb, op_rmb, 
    # 0x6c
    op_rfb, op_rfb, op_rfb, op_rfb, # 0x6f
    # 0x70
    op_spb, op_spb, op_spb, op_spb, 
    # 0x74 
    op_seb, op_seb, op_seb, op_seb, # 0x77
    # 0x78
    op_smb, op_smb, op_smb, op_smb, 
    # 0x7c
    op_sfb, op_sfb, op_sfb, op_sfb, # 0x7f

    # op & 0xf0
    # 0x80
    op_ldz, op_ldz, op_ldz, op_ldz, op_ldz, op_ldz, op_ldz, op_ldz, # 0x87
    op_ldz, op_ldz, op_ldz, op_ldz, op_ldz, op_ldz, op_ldz, op_ldz, # 0x8f
    # 0x90
    op_li, op_li, op_li, op_li, op_li, op_li, op_li, op_li, # 0x97
    op_li, op_li, op_li, op_li, op_li, op_li, op_li, op_li, # 0x9f 
    # 0xa0
    op_jmpcal, op_jmpcal, op_jmpcal, op_jmpcal, op_jmpcal, op_jmpcal, op_jmpcal, op_jmpcal, # 0xa7
    op_jmpcal, op_jmpcal, op_jmpcal, op_jmpcal, op_jmpcal, op_jmpcal, op_jmpcal, op_jmpcal, # 0xaf
    # 0xb0
    op_czp, op_czp, op_czp, op_czp, op_czp, op_czp, op_czp, op_czp, # 0xb7
    op_czp, op_czp, op_czp, op_czp, op_czp, op_czp, op_czp, op_czp, # 0xbf

    # 0xc0 -> 0xff
    op_jcp, op_jcp, op_jcp, op_jcp, op_jcp, op_jcp, op_jcp, op_jcp, # 0xc7
    op_jcp, op_jcp, op_jcp, op_jcp, op_jcp, op_jcp, op_jcp, op_jcp, # 0xcf
    op_jcp, op_jcp, op_jcp, op_jcp, op_jcp, op_jcp, op_jcp, op_jcp, # 0xd7
    op_jcp, op_jcp, op_jcp, op_jcp, op_jcp, op_jcp, op_jcp, op_jcp, # 0xdf
    op_jcp, op_jcp, op_jcp, op_jcp, op_jcp, op_jcp, op_jcp, op_jcp, # 0xe7
    op_jcp, op_jcp, op_jcp, op_jcp, op_jcp, op_jcp, op_jcp, op_jcp,  # 0xef
    op_jcp, op_jcp, op_jcp, op_jcp, op_jcp, op_jcp, op_jcp, op_jcp, # 0xf7
    op_jcp, op_jcp, op_jcp, op_jcp, op_jcp, op_jcp, op_jcp, op_jcp  # 0xff
]


# print("#include <stdio.h>")
# print("#include \"astro.h\"")
# print("uint8_t astro_loop(uint16_t addr) {")
# print("#include \"switch.h\"")
# print("switch(addr) {")
for k,r in enumerate(rom):
    rp = int((r['addr'] & 0xf00) / 256)
    # print(rp)
    if rp != page:
        page = rp
        if page !=0:
            print("} // end switch")
            print("return (0); ")
            print("}")
        print(f"uint8_t astro_loop{page}(uint16_t addr) {{")
        print("switch(addr) {")

        # print("switch(addr) {")
    skipcycles = 0
    if (k+2)< len(rom):
        next = rom[k+2]
        skipcycles += rom[k+1]['cycles']

    if r['opid'] == '90':
        p = k
        while(p < 0x800):
            if rom[p]['opid']!= '90':
                break
            skipcycles += rom[p]['cycles']
            p += 1
        next = rom[p]

    next['skipcycles'] = skipcycles
    print(f" case 0x{r['addr']:03x}:")
    print(f"l0{r['addr']:03x}: // {k}")
    # if docomments:
        # print(f"asm (\";l0{r['addr']:03x} \");")
        # print(f"asm(\";{r['opcode']}\");")
    # print(f"printf(\"{r['opcode']}\\n\");")
    # print(f"    cpu.pc = 0x{r['addr']:04x};")
    # print(f"    cpu.op = 0x{int(r['opid'],16):02x};")
    tickcount += r['cycles'];
    
    # print(f"// TC: {tickcount}")
    if(int(r['opid'],16) >=0xa0):
        if tickcount > 0:
            print(f"    ticks+={tickcount};")
        print("    tick();")
        tickcount = 0

    # print(f"    ticks+={r['cycles']};")

    res = opcode_table[int(r['opid'],16)](r,next)
    if res == """
    // do nothing;
    
    """:
        print(r,next)
        exit("Bad opcode: " + r['opcode'])
        
    else:
        print(res)
    # print(opcode_table[int(r['opid'],16)](r))


print("} // end case")
print("return (0); ")
print("}")