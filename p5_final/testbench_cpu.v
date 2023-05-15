`define Ram_size 10'h3ff       //size of ram
`define Rom_size 10'h3ff       //size of rom
`define CYCLE    100           // generate clock
`define GRF31 5'b11111

module testbench_cpu() ;
    reg             clk, reset ;
    
    // instantiate the MiniUART module
    mips my_CPU( .clk(clk), .reset(reset) ) ;// instantiate mips
    
    //
    initial begin
        sys_reset ;                       // reset
        test1 ;
        
    end
      
    // generate clock  
    always  
        #(`CYCLE) clk = ~clk ;
    
    // task to reset
    task    sys_reset;
      begin
        clk     = 0 ;
        reset = 0;
      end
    endtask
    
    // task to test
    task    test1 ;      
        begin
            $readmemh ("code.txt",my_CPU.F_im.Instr_memory);
            $display  ("rom loaded  successfully")  ;
            $readmemh ("data.txt",my_CPU.M_dm.Ram)  ;
            $display  ("ram loaded  successfully")  ;
            #23000  ;
        end
    endtask
        
endmodule