create or replace procedure insert_installment (v_contract_id number, v_pay_inst_no number, v_no_of_months number)
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