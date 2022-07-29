create or replace procedure update_pay_no (v_pay_inst_no number,  v_contract_id number)
is 
        --    v_pay_inst_no number(3) := 3;
        --    v_contract_id number(3) := 101;
begin

             UPDATE CONTRACTS
            SET payments_installments_no =  v_pay_inst_no
            WHERE contract_id =  v_contract_id ;



end;