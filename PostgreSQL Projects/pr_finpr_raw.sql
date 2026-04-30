select pr.id, pr.name, finpr.product_id, finpr.client_name, finpr.order_number, r.product_id, r.order_number 
from public.i_product as pr
left outer join public.i_invoice_finished_product as finpr 
on pr.id=finpr.product_id
left outer join public.i_invoice_row_material as r
on finpr.product_id=r.product_id and finpr.order_number=r.order_number


select pr.id, pr.name, finpr.product_id, finpr.client_name, finpr.order_number, r.product_id, r.order_number 
from public.i_product as pr
full outer join public.i_invoice_finished_product as finpr 
on pr.id=finpr.product_id
full outer join public.i_invoice_row_material as r
on finpr.product_id=r.product_id and finpr.order_number=r.order_number

