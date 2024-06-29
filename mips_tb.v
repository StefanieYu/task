//~ `New testbench
`timescale  1ns / 1ps

module tb_mips;



// mips Inputs
reg   clk                                  = 0 ;
reg   rst                                  = 0 ;

// mips Outputs



initial 
begin
    clk = 0;
    forever #10 clk = ~clk;
end

initial
begin
    $monitor("PC = %8x, IR = %8x",u_mips.u_datapath.u_pc.pc,u_mips.u_datapath.u_im_1k.dout);
    #5 rst  =  1;
    #15 rst = 0;
end

always @(posedge clk)
    begin
    if(u_mips.u_datapath.u_gpr.reg_wr)
        begin
            $display("R[00-07] = %8x, %8x, %8x, %8x, %8x, %8x, %8x, %8x",
            u_mips.u_datapath.u_gpr.register_file[0],u_mips.u_datapath.u_gpr.register_file[1],
            u_mips.u_datapath.u_gpr.register_file[2],u_mips.u_datapath.u_gpr.register_file[3],
            u_mips.u_datapath.u_gpr.register_file[4],u_mips.u_datapath.u_gpr.register_file[5],
            u_mips.u_datapath.u_gpr.register_file[6],u_mips.u_datapath.u_gpr.register_file[7]);
            $display("R[08-15] = %8x, %8x, %8x, %8x, %8x, %8x, %8x, %8x",
            u_mips.u_datapath.u_gpr.register_file[8],u_mips.u_datapath.u_gpr.register_file[9],
            u_mips.u_datapath.u_gpr.register_file[10],u_mips.u_datapath.u_gpr.register_file[11],
            u_mips.u_datapath.u_gpr.register_file[12],u_mips.u_datapath.u_gpr.register_file[13],
            u_mips.u_datapath.u_gpr.register_file[14],u_mips.u_datapath.u_gpr.register_file[15]);
            $display("R[16-23] = %8x, %8x, %8x, %8x, %8x, %8x, %8x, %8x",
            u_mips.u_datapath.u_gpr.register_file[16],u_mips.u_datapath.u_gpr.register_file[17],
            u_mips.u_datapath.u_gpr.register_file[18],u_mips.u_datapath.u_gpr.register_file[19],
            u_mips.u_datapath.u_gpr.register_file[20],u_mips.u_datapath.u_gpr.register_file[21],
            u_mips.u_datapath.u_gpr.register_file[22],u_mips.u_datapath.u_gpr.register_file[23]);
            $display("R[24-31] = %8x, %8x, %8x, %8x, %8x, %8x, %8x, %8x",
            u_mips.u_datapath.u_gpr.register_file[24],u_mips.u_datapath.u_gpr.register_file[25],
            u_mips.u_datapath.u_gpr.register_file[26],u_mips.u_datapath.u_gpr.register_file[27],
            u_mips.u_datapath.u_gpr.register_file[28],u_mips.u_datapath.u_gpr.register_file[29],
            u_mips.u_datapath.u_gpr.register_file[30],u_mips.u_datapath.u_gpr.register_file[31]);
        end
    if(u_mips.u_datapath.u_dm_1k.we)
        begin
            $display("Write %8x at address %8x",u_mips.u_datapath.u_dm_1k.din,{22'b0,u_mips.u_datapath.u_dm_1k.addr});
        end
    end

mips  u_mips (
    .clk                     ( clk   ),
    .rst                     ( rst   )
);

integer i;
initial
begin
    $readmemh("single_cycle_processor/src/code/p1-test.txt",u_mips.u_datapath.u_im_1k.im);
    $dumpfile("single_cycle_processor/build/mips.vcd");
    $dumpvars(0,tb_mips);
    for(i = 0;i < 32;i++)   
        $dumpvars(0,u_mips.u_datapath.u_dm_1k.dm[i]);

    for(i = 0;i < 32;i++)   
        $dumpvars(0,u_mips.u_datapath.u_gpr.register_file[i]);
    #2000;
    $display("R[00-07] = %8x, %8x, %8x, %8x, %8x, %8x, %8x, %8x",
            u_mips.u_datapath.u_gpr.register_file[0],u_mips.u_datapath.u_gpr.register_file[1],
            u_mips.u_datapath.u_gpr.register_file[2],u_mips.u_datapath.u_gpr.register_file[3],
            u_mips.u_datapath.u_gpr.register_file[4],u_mips.u_datapath.u_gpr.register_file[5],
            u_mips.u_datapath.u_gpr.register_file[6],u_mips.u_datapath.u_gpr.register_file[7]);
            $display("R[08-15] = %8x, %8x, %8x, %8x, %8x, %8x, %8x, %8x",
            u_mips.u_datapath.u_gpr.register_file[8],u_mips.u_datapath.u_gpr.register_file[9],
            u_mips.u_datapath.u_gpr.register_file[10],u_mips.u_datapath.u_gpr.register_file[11],
            u_mips.u_datapath.u_gpr.register_file[12],u_mips.u_datapath.u_gpr.register_file[13],
            u_mips.u_datapath.u_gpr.register_file[14],u_mips.u_datapath.u_gpr.register_file[15]);
            $display("R[16-23] = %8x, %8x, %8x, %8x, %8x, %8x, %8x, %8x",
            u_mips.u_datapath.u_gpr.register_file[16],u_mips.u_datapath.u_gpr.register_file[17],
            u_mips.u_datapath.u_gpr.register_file[18],u_mips.u_datapath.u_gpr.register_file[19],
            u_mips.u_datapath.u_gpr.register_file[20],u_mips.u_datapath.u_gpr.register_file[21],
            u_mips.u_datapath.u_gpr.register_file[22],u_mips.u_datapath.u_gpr.register_file[23]);
            $display("R[24-31] = %8x, %8x, %8x, %8x, %8x, %8x, %8x, %8x",
            u_mips.u_datapath.u_gpr.register_file[24],u_mips.u_datapath.u_gpr.register_file[25],
            u_mips.u_datapath.u_gpr.register_file[26],u_mips.u_datapath.u_gpr.register_file[27],
            u_mips.u_datapath.u_gpr.register_file[28],u_mips.u_datapath.u_gpr.register_file[29],
            u_mips.u_datapath.u_gpr.register_file[30],u_mips.u_datapath.u_gpr.register_file[31]);

    $display("Address[00-1c] = %8x, %8x, %8x, %8x, %8x, %8x, %8x, %8x",
            {u_mips.u_datapath.u_dm_1k.dm[3],u_mips.u_datapath.u_dm_1k.dm[2],u_mips.u_datapath.u_dm_1k.dm[1],u_mips.u_datapath.u_dm_1k.dm[0]},
            {u_mips.u_datapath.u_dm_1k.dm[7],u_mips.u_datapath.u_dm_1k.dm[6],u_mips.u_datapath.u_dm_1k.dm[5],u_mips.u_datapath.u_dm_1k.dm[4]},
            {u_mips.u_datapath.u_dm_1k.dm[11],u_mips.u_datapath.u_dm_1k.dm[10],u_mips.u_datapath.u_dm_1k.dm[9],u_mips.u_datapath.u_dm_1k.dm[8]},
            {u_mips.u_datapath.u_dm_1k.dm[15],u_mips.u_datapath.u_dm_1k.dm[14],u_mips.u_datapath.u_dm_1k.dm[13],u_mips.u_datapath.u_dm_1k.dm[12]},
            {u_mips.u_datapath.u_dm_1k.dm[19],u_mips.u_datapath.u_dm_1k.dm[18],u_mips.u_datapath.u_dm_1k.dm[17],u_mips.u_datapath.u_dm_1k.dm[16]},
            {u_mips.u_datapath.u_dm_1k.dm[23],u_mips.u_datapath.u_dm_1k.dm[22],u_mips.u_datapath.u_dm_1k.dm[21],u_mips.u_datapath.u_dm_1k.dm[20]},
            {u_mips.u_datapath.u_dm_1k.dm[27],u_mips.u_datapath.u_dm_1k.dm[26],u_mips.u_datapath.u_dm_1k.dm[25],u_mips.u_datapath.u_dm_1k.dm[24]},
            {u_mips.u_datapath.u_dm_1k.dm[31],u_mips.u_datapath.u_dm_1k.dm[30],u_mips.u_datapath.u_dm_1k.dm[29],u_mips.u_datapath.u_dm_1k.dm[28]});
    $finish;
end

endmodule