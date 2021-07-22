SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE C_SP_Stock_Level @w_id			INT, @d_id			TINYINT, @threshold		SMALLINT as declare 	@o_id_low	INT, 	@o_id_high	INT select @o_id_low = (d_next_o_id - 20), 	@o_id_high = (d_next_o_id - 1) from C_District where d_w_id = @w_id 	and d_id = @d_id select count(distinct(s_i_id)) from C_Stock, C_Order_Line where ol_w_id = @w_id 	and ol_d_id = @d_id 	and ol_o_id between @o_id_low and @o_id_high 	and s_w_id = ol_w_id 	and s_i_id = ol_i_id 	and s_quantity < @threshold 
GO
