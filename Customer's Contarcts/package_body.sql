create or replace package body intallment_pkg
 is 
  function calc_pay_inst_no ( v_contract_id number , v_no_of_months out number)
return number
is
        -- v_contract_id number(6) := 101 ;
        v_client_record contracts%rowtype;
        v_date_difference number(3) ;
        v_pay_inst_no number(3);
BEGIN
            select * into V_client_record from contracts where contract_id = v_contract_id ;

            v_date_difference := MONTHS_BETWEEN(v_client_record.contract_enddate, v_client_record.contract_startdate );
            IF v_client_record.contract_payment_type = 'ANNUAL' THEN
                    v_no_of_months := 12;
                     v_pay_inst_no := v_date_difference / v_no_of_months;
            ELSIF  V_client_record.contract_payment_type = 'QUARTER' THEN
                      v_no_of_months := 3;
                     v_pay_inst_no := v_date_difference / v_no_of_months;
            ELSIF  V_client_record.contract_payment_type = 'MONTHLY' THEN
                     v_no_of_months := 1;
                     v_pay_inst_no := v_date_difference / v_no_of_months; 
            ELSIF  V_client_record.contract_payment_type = 'HALF_ANNUAL' THEN
                      v_no_of_months := 6;
                     v_pay_inst_no := v_date_difference / v_no_of_months;
            END IF;
            
            
 return  v_pay_inst_no;          
 end;
 procedure update_pay_no (v_pay_inst_no number,  v_contract_id number)
is 
        --    v_pay_inst_no number(3) := 3;
        --    v_contract_id number(3) := 101;
begin

             UPDATE CONTRACTS
            SET payments_installments_no =  v_pay_inst_no
            WHERE contract_id =  v_contract_id ;
end;
procedure insert_installment (v_contract_id number, v_pay_inst_no number, v_no_of_months number)
is
       --   v_pay_inst_no number(3):= 2;
          v_client_record contracts%rowtype;
      --    v_contract_id number(3) := 101;
          v_new_date date;
      --    v_no_of_months number(3) := 3;

begin
          select * into v_client_record from contracts where contract_id = v_contract_id;
                
          for i in 0 .. (v_pay_inst_no -1)   loop
                  if i = 0 then
                      INSERT INTO INSTALLMENTS_PAID (installment_id, contract_id, installment_date, installment_amount, paid)
                       values(inst_seq.nextval, v_client_record.contract_id, v_client_record.contract_startdate,( v_client_record.contract_total_fees - coalesce(v_client_record.contract_deposit_fees, 0)) / v_client_record.payments_installments_no, 0);
                  else 
                                  v_new_date := add_months(v_client_record.contract_startdate, i*v_no_of_months);
                       INSERT INTO INSTALLMENTS_PAID (installment_id, contract_id, installment_date, installment_amount, paid)
                       values(inst_seq.nextval, v_client_record.contract_id,  v_new_date,(v_client_record.contract_total_fees - coalesce(v_client_record.contract_deposit_fees, 0)) / v_client_record.payments_installments_no, 0);
                         
                  end if ;
          end loop ;
end;


end;