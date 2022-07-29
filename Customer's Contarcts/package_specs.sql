create or replace package intallment_pkg
 is 
function calc_pay_inst_no ( v_contract_id number , v_no_of_months out number)
return number;
procedure update_pay_no (v_pay_inst_no number,  v_contract_id number);
procedure insert_installment (v_contract_id number, v_pay_inst_no number, v_no_of_months number);

end;