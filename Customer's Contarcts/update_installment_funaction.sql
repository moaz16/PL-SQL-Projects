create or replace function calc_pay_inst_no ( v_contract_id number)
return number
is
        -- v_contract_id number(6) := 101 ;
        v_client_record contracts%rowtype;
        v_date_difference number(3) ;
        v_pay_inst_no number(3);
        v_no_of_months number(3);
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