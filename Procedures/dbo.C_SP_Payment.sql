SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE C_SP_Payment @w_id		INT, @c_w_id		INT, @h_amount	NUMERIC(6,2), @d_id		TINYINT, @c_d_id		TINYINT, @c_id		INT, @c_last		CHAR(16) = '' as declare 	@w_street_1		CHAR(20), 	@w_street_2		CHAR(20), 	@w_city			CHAR(20), 	@w_state		CHAR(2), 	@w_zip			CHAR(9), 	@w_name			CHAR(10), 	@d_street_1		CHAR(20), 	@d_street_2		CHAR(20), 	@d_city			CHAR(20), 	@d_state		CHAR(2), 	@d_zip			CHAR(9), 	@d_name			CHAR(10), 	@c_first		CHAR(16), 	@c_middle		CHAR(2), 	@c_street_1		CHAR(20), 	@c_street_2		CHAR(20), 	@c_city			CHAR(20), 	@c_state		CHAR(2), 	@c_zip			CHAR(9), 	@c_phone		CHAR(16), 	@c_since		DATETIME, 	@c_credit		CHAR(2), 	@c_credit_lim	NUMERIC(12,2), 	@c_balance		NUMERIC(12,2), 	@c_discount		NUMERIC(4,4), 	@data1			CHAR(250), 	@data2			CHAR(250), 	@c_data_1		CHAR(250), 	@c_data_2		CHAR(250), 	@datetime		DATETIME, 	@w_ytd			NUMERIC(12,2), 	@d_ytd			NUMERIC(12,2), 	@cnt			SMALLINT, 	@val			SMALLINT, 	@screen_data	CHAR(200), 	@d_id_local		TINYINT, 	@w_id_local		INT, 	@c_id_local		INT select @screen_data = '' begin transaction payment 	select @datetime = getdate() 	if (@c_id = 0) 	begin 		select @cnt = count(*) 		from C_Customer with (repeatableread) 		where c_last = @c_last 		and c_w_id = @c_w_id 		and c_d_id = @c_d_id 		select @val = (@cnt + 1)/2 		set rowcount @val 		select @c_id = c_id 		from C_Customer with (repeatableread) 		where c_last = @c_last 		and c_w_id = @c_w_id 		and c_d_id = @c_d_id 		order by c_w_id, c_d_id, c_last, c_first 		set rowcount 0 	end 	update C_Customer 	set c_balance = c_balance - @h_amount, 		@c_balance = c_balance - @h_amount, 		c_payment_cnt = c_payment_cnt + 1, 		c_ytd_payment = c_ytd_payment + @h_amount, 		@c_first = c_first, 		@c_middle = c_middle, 		@c_last = c_last, 		@c_street_1 = c_street_1, 		@c_street_2 = c_street_2, 		@c_city = c_city, 		@c_state = c_state, 		@c_zip = c_zip, 		@c_phone = c_phone, 		@c_credit = c_credit, 		@c_credit_lim = c_credit_lim, 		@c_discount = c_discount, 		@c_since = c_since, 		@data1 = c_data1, 		@data2 = c_data2, 		@c_id_local = c_id 	where c_id = @c_id 	and c_w_id = @c_w_id 	and c_d_id = @c_d_id 	if (@c_credit = 'BC') 	begin 		select @c_data_2 = substring(@data1, 209, 42) + substring(@data2, 1, 208) 		select @c_data_1 = convert(CHAR(5), @c_id) + 			convert(CHAR(4), @c_d_id) + 			convert(CHAR(5), @c_w_id) + 			convert(CHAR(4), @d_id) + 			convert(CHAR(5), @w_id) + 			convert(CHAR(19), @h_amount) + 			substring(@data1, 1, 208) 		update C_Customer 		set c_data1 = @c_data_1, 			c_data2 = @c_data_2  		where c_id = @c_id 		and c_w_id = @c_w_id 		and c_d_id = @c_d_id 		select @screen_data = substring(@c_data_1,1,200) 	end 	update C_District 	set d_ytd = d_ytd + @h_amount, 		@d_street_1 = d_street_1, 		@d_street_2 = d_street_2, 		@d_city = d_city, 		@d_state = d_state, 		@d_zip = d_zip, 		@d_name = d_name, 		@d_id_local = d_id 	where d_w_id = @w_id 	and d_id = @d_id 	update C_Warehouse 	set w_ytd = w_ytd + @h_amount, 		@w_street_1 = w_street_1, 		@w_street_2 = w_street_2, 		@w_city = w_city, 		@w_state = w_state, 		@w_zip = w_zip, 		@w_name = w_name, 		@w_id_local = w_id 	where w_id = @w_id 	insert into C_History  (h_c_id, h_c_d_id, h_c_w_id, h_d_id, 		h_w_id, h_date, h_amount, h_data) 		values ( 		@c_id_local, @c_d_id, @c_w_id, @d_id_local, 		@w_id_local, @datetime, @h_amount, @w_name + '$$$$'+@d_name) commit transaction payment select @c_id, 	@c_last, 	@datetime, 	@w_street_1, 	@w_street_2, 	@w_city, 	@w_state, 	@w_zip, 	@d_street_1, 	@d_street_2, 	@d_city, 	@d_state, 	@d_zip, 	@c_first, 	@c_middle, 	@c_street_1, 	@c_street_2, 	@c_city, 	@c_state, 	@c_zip, 	@c_phone, 	@c_since, 	@c_credit, 	@c_credit_lim, 	@c_discount, 	@c_balance, 	@screen_data 
GO
