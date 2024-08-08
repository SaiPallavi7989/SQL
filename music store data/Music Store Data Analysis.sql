create database music;
use music;

/*1.who is the senior most employee based on job title?*/
select * from employee
order by levels 
desc limit 1;

/*2.which country has the most invoice?*/
select count(*) as invoice_count,billing_country 
from invoice 
group by billing_country 
order by invoice_count 
desc limit 1;

/*3.what are the top 3 values of total invoice?*/
select total from invoice order by total desc limit 3;

/*4.which city has the best customers?*/
select billing_city, sum(total) as total 
from invoice 
group by billing_city 
order by total 
desc limit 1;

/*5.Which customer spent more money?*/
select customer.customer_id,customer.first_name,customer.last_name, sum(total) as total
from customer
join invoice on customer.customer_id=invoice.customer_id 
group by customer.customer_id,first_name,last_name order by total desc limit 1;

/*6.Email,first name,last name and genre of all rock music listeners*/
select distinct email,first_name,last_name 
from customer
join invoice on customer.customer_id=invoice.customer_id
join invoice_line on invoice.invoice_id=invoice_line.invoice_id
where track_id in(
 select track_id from track
 join genre on track.genre_id=genre.genre_id
 where genre.name like 'Rock'
 )
 order by email;
 
 /*7.Artist and total track count of the top 10 rock bands*/
 select artist.artist_id,artist.name, count(album2.album_id) as Total_Songs
 from album2 
 join track on album2.album_id=track.album_id
 join artist on album2.artist_id=artist.artist_id
 join genre on genre.genre_id=track.genre_id
 where genre.name like 'Rock'
 group by artist_id,name
 order by Total_songs desc
 limit 10;
 
 /*8.Name, Milliseconds of each track whose length is longer than average song length*/
 select name,milliseconds from track where milliseconds>(
 select avg(milliseconds) as avgmilliseconds from track)
 order by milliseconds desc;
 
 /*9.Amount spent by each customer on artists*/
  with best_selling_artist as(
  select artist.artist_id,artist.name,
  sum(invoice_line.unit_price*invoice_line.quantity) as amount_spent
  from invoice_line
  join track on track.track_id=invoice_line.track_id
  join album2 on album2.album_id=track.album_id
  join artist on artist.artist_id=album2.artist_id
  group by 1,2
  order by 3 desc
  limit 1
  )
  select c.customer_id ,c.first_name,c.last_name,bsa.name as artist_name,sum(il.unit_price*il.quantity) as amount_spent
  from invoice i
  join customer c on c.customer_id=i.customer_id
  join invoice_line il on il.invoice_id=i.invoice_id
  join track t on t.track_id=il.track_id
  join album2 alb on alb.album_id=t.album_id
  join best_selling_artist bsa on bsa.artist_id=alb.artist_id
  group by 1,2,3,4
  order by 5 desc;
  
  /*10.what is the most popular genre for each country*/
  with popular_genre as
  (
    select count(invoice_line.quantity) as purchases,customer.country,genre.name,genre.genre_id,
    row_number() over(partition by customer.country order by count(invoice_line.quantity)desc) as RowNo
    from invoice_line
    join invoice on invoice.invoice_id=invoice_line.invoice_id
    join customer on customer.customer_id=invoice.customer_id
    join track on track.track_id=invoice_line.track_id
    join genre on genre.genre_id=track.genre_id
    group by 2,3,4
    order by 2 asc, 1 desc
    )
    select * from popular_genre where RowNo<=1;    

/*The line starts a Common Table Expression (CTE) named popular_genre. 
A CTE is a temporary result set that you can reference within a SELECT, INSERT, UPDATE, or DELETE statement.
ROW_NUMBER() OVER(PARTITION BY customer.country ORDER BY COUNT(invoice_line.quantity) DESC) AS RowNo: 
Assigns a row number to each genre within each country, ordered by the number of purchases in descending order.*/

/*11.Country along with customers and how much they spent*/
with customer_with_country as(
select customer.customer_id,first_name,last_name,billing_country,sum(total) as total_spending,
row_number() over(partition by billing_country order by sum(total) desc) as RowNo
from invoice
join customer on customer.customer_id=invoice.customer_id
group by 1,2,3,4
order by 2,3 desc)

select * from customer_with_country where RowNo<=1;





 



