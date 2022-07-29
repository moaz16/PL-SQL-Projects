declare 
        v_pay_inst_no number(3);


begin

          v_pay_inst_no := calc_pay_inst_no(102);
                     dbms_output.put_line(v_pay_inst_no);



end;