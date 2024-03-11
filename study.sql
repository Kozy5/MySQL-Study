My SQL 기본 구조
select *  // 모든 데이터 조회 
from ~~ // 테이블 지정
where // 조건(필터)을(를) 줄  수 있는 절



My SQL where 절

★ 기본적인 조건문

select *            // 모든 데이터 조회
from food_orders    // food_orders 이라는 테이블에서
where cuisine_type ="Korean" // 한식만 뽑아줘

# 영어 대소문자 구분해야함 korean (x) Korean(O)
# 자료형 구분 ex) 문자형 '~' 숫자형 1 

★ 필터 표현

1. <> //같지 않음
where gender<>'male' // gender에 male이 아닌값만 뽑아줘
출력 : gender = female female female . . .

2.between A and B  // A이상 B이하 값
where age between 21 and 23 // age에 21이상23이하의 값만 뽑아줘
출력 : age = 21,22,23

3. in(A,B,C) '포함'하는 조건 주기 (콕 찝어서 선택적인 조건)
where age in(15,21,25) // age에 15, 21, 25 인 값만 뽑아줘
출력 : age = 15,21,25
자료형 구분해서 문자형,숫자형 모두 가능

4. like '시작문자%' ,'%포함문자%' ,'%종료문자' // 포함되는 값으로 조건 주기
where name like '김%' // 이름(name)중에 김씨로 시작되는 값을 찾아줘
where name like '%태%'// 이름(name)중에 중간에 태 가 들어가는 값을 찾아줘
where name like '%형' // 이름(name)중에 형으로 끝나는 값을 찾아줘

★ 필터조건 여러개를 적용해 할 때 논리 연산자

1. AND // 그리고 
age >= 20              // 나이가 20세 이상
and gender = 'female' // "이고"(그리고), 여성

2. OR // 또는 
age >= 20             // 나이가 20세 이상
or gender = 'female'  // 이거나("또는") ,여성

3. NOT // 아닌 
not gender = 'female' // 여성이 아닌

계산식

합계와 평균구하기
select SUM(컬럼명) 별명
       AVG(컬럼명) 별명
from 테이블명
결과 : 
SUM:컬럼 전체 합한 값 , 
AVG : 컬럼 전체 평균 값


select COUNT(* 혹은 1)
       COUNT(distinct 컬럼명)
from 테이블
결과 : 
COUNT(* 혹은 1) : 테이블 속 전체 로우 갯수 카운트, 
COUNT(distinct 컬럼명) : 해당 컬럼속 값의 "종류"갯수 카운트

최솟값,최대값 구하기
select MIN(컬럼명) 별명,
       MAX(컬럼명) 별명
from 테이블명
결과 : 
MIN:컬럼 전체 속 최솟값, 
MAX:컬럼 전체 속 최대값

*실습 information*
table name 
1. food_orders
2. payments
3. customers

SQL TIP
[예시] "주문 금액(1-2)"이 "30,000원 이상(1-3)"인 주문건의 "갯수 구하기1-4"
1. Query를 적기 전에 흐름을 생각해보기
1-1 어떤 "테이블"에서 데이터를 뽑을것인가
1-2 어떤 컬럼을 사용할 것인가
1-3 어떤 조건을 지정해야 하는가
1-4 어떤 함수(수식)을 이용해야 하는가

[실습 1] 음식점별 주문금액의 최댓값 조회하기
1-1 food_orders
1-2 restaurant_name,price
1-3 group by
1-4 max() 

그룹별(종류별) 값 구하기
group by // select,from,where 과 같은 위치에 쓰임


select restaurant_name,
       max(price) max_price
from food_orders
group by restaurant_name
결과 : restaurant_name : 가게이름별로 출력(중복시 미출력 종류별이니까),
price : 주문금액 최댓값만 출력 // 가게 이름별 주문금액 최댓값만 출력 

[실습 2] 결제타입별 최근결제일 조회하기
2-1 payments
2-2 pay_type, date
2-3 group by 
2-4 max()

select pay_type,
       max(date) near_date
from payments
group by pay_type
결과 : pay_type cash,card 2개만 출력(결제종류가 2가지뿐 종류별이니까),
 date : 가장 최근(높은 숫자)일 출력 // ex) cash 2023/03/02 card 2021/02/04
 

 해당 컬럼을 기준으로 정렬하기
 order by(컬럼명) // 해당컬럼을 기준으로 오름차순으로 정렬해줘
 order by(컬럼명) desc // 해당컬럼을 기준으로 내림차순으로 정렬해줘
 order by A,B // A값을 기준으로 먼저 정렬해주고 A속에서 B를 정렬
 ex) order by gender,name 결과 : 여자 강%~하% 이후 남자 강%~하%

 실습[1] 음식점별 주문 금액 최댓값 조회하기 - 최댓값 기준으로 내림차순 정렬
 1-1 food_orders
 1-2 restaurant_name, price
 1-3 group by order by
 1-4 max()

 select restaurant_name,
        max(price) max_price
from food_orders
group by restaurant_name
order by max(price) desc // max(price) 함수 적용된 컬럼으로 작성해야함


 실습[2] 고객을 이름 순으로 오름차순으로 정렬하기
 1-1 customers
 1-2 name
 1-3 order by
 1-4 x

 select * //컬럼 기준,group by도 없으면 전체 기준으로 함..
 from customers
 order by name

 select *
from customers

2-6 SQL 구조맞추기 연습

select cuisine_type,
       sum(delivery_time) total_delivery_time
from food_orders
where day_of_week='weekend'
group by cuisine_type
order by sum(delivery_time) desc

select age,
	   count(name) count_of_name
from customers
where age between 20 and 40
group by age
order by age

3주차

기존 데이터 변환
replace(col,A,B) // 특정 컬럼에 A를 B로 바꿔줘

replace(name,'철수','짱구') // name 컬럼에 '철수'라는 단어를,'짱구'로 바꿔줘

[실습] food_orders 테이블에 주소 컬럼에 '문곡리'를 '문가리'로 바꿔줘
select addr '원래 주소명',
       replace(addr,'문곡리','문가리') '바뀐 주소명'
from food_orders
where addr like '%문곡리%'

특정 문자만 조회
substring(col,A,B) // 특정 컬럼에 A번째 글자부터(기준으로) B글자 만큼만 추출해줘
substring(addr,1,2)// addr 컬럼에 1번째 글자부터 2글자 만큼만 추출해줘

[실습] food_orders 테이블에 주소 컬럼에 '서울특별시'중에서 시 명만 추출해줘
select addr '원래주소명',
       substr(addr,1,2) '시' //첫번째 글자부터(기준으로) 2글자
from food_orders
where addr like '%서울특별시%'

결과 = 원래주소명 : 서울특별시 ~구 ~동
       시 : 서울

[실습 1 ] 출력값을 잘못 이해한 예시 (시청 전 먼저 구현해본 것)
select concat('`',substr(addr,1,2),'`',
',','`',cuisine_type,'`',',','`',avg(price),'`')	   
from food_orders fo 
where addr like '%서울특별시%'
group by cuisine_type 
출력 : '서울','Korean','금액'

[본 실습 1]
서울 지역의 음식 타입별 평균 음식 주문금 구하기(출력 : '서울','타입','평균금액')
select substr(addr,1,2) '지역',
       cuisine_type '음식타입',
       avg(price) '평균금액'
from food_orders
where addr like '%서울%'
group by 1,2

[본 실습 2] 도메인의 뜻을 오해해서 substr을 고려하지 못한 예시(시청 전 먼저 구현해본 것)
이메일 도메인별 고객수와 평균 연령 구하기
select email '이메일',
	count(email)'고객수',
       avg(age) '평균연령'
from customers
group by email

[본 실습 2]
이메일 도메인별 고객수와 평균 연령 구하기
select substr(email,10) '도메인',
       count(1) '고객수',
       avg(age)'평균연령'
from customers
group by 1 
출력 : '도메인','고객수','평균연령'

[본 실습 3] (시청 전 먼저 구현해본 것)
'[지역(시도)] 음식점이름(음식종류)' 컬럼을 만들고, 총 주문건수 구하기
SELECT concat('[',substr(addr,1,2),']',restaurant_name,'(',cuisine_type,')') '[지역]음식점이름(음식종류)',
	   sum(quantity) '총 주문건수'
from food_orders fo 
group by 1

if문
if(조건,조건충족할때,조건 충족하지 않을 때)

[if문 예제 1]
select restaurant_name,
       cuisine_type "원래 음식 타입",
       if(cuisine_type='Korean', '한식', '기타') "음식 타입"
from food_orders
[if문 예제2]
select addr "원래 주소",
       if(addr like '%평택군%', replace(addr, '문곡리', '문가리'), addr) "바뀐 주소"
from food_orders
where addr like '%문곡리%'

case when 문
1. 시작 시 case when 으로 시작
2. 이후에는 when으로 조건 추가 이후 반환값을 받을땐 then 사용
3. 이 외는 else 사용 
4. 마무리는 end
5. 컬럼명 작성 시 , 로 마무리

[실습 1]
음식타입이 Korean일 경우 한식 japanese,chinese 일 경우 아시아로 출력 그 외에는 기타로 출력
select case when cuisine_type = 'Korean' then '한식'
			when cuisine_type in('japanese','chinese') then '아시아'
			else '기타' end '음식타입',
		cuisine_type 
from food_orders

[실습 2]
음식 단가를 주문 수량이 1일 때는 음식 가격, 주문 수량이 2개 이상일 때는 음식가격/주문수량 으로 지정
(이 예제는 if문과 case when문 두가지 모두 가능하니 연습 해보자)
if 문 version
select order_id,
       price,
       quantity,
       if(quantity= 1,price,price/quantity) '음식 단가'
from food_orders

case when version
select order_id,
       price,
       quantity,
       case when quantity = 1 then price
            when quantity >=2 then price/quantity end '음식 단가'
from food_orders

[활용 실습]
음식 타입과 같이 새로운 카테고리를 만들 수 있습니다.
select cuisine_type,
	   case when cuisine_type = 'Korean' then '한국 음식'
	   	 	when cuisine_type in('japanese','chinese','thai','indian') then '아시아 음식'
	   	 	when cuisine_type = 'American' then  '미국 음식'
	   	 	when cuisine_type = 'italin' then '유럽 음식'
	   	 	else '기타' end '음식 카테고리'
from food_orders fo 
활용 실습 2 
고객 분류 
10대 여성, 10대 남성, 20대 여성, 20대 남성 등 카테고리

연산식을 적용할 조건 지정
수수료를 계산할 때 흔히들 현금 사용, 카드사용을 나누곤 하는데
현금일 때의 수수료율과 카드일 때의 수수료율 다르게 
if 혹은 case문으로 각각 다른 수수료율 혹은 수수료 계산 방식 적용

3-5 [실습 1] (시청 전 먼저 구현해본것)
1. 10세 이상, 30세 미만 고객의 나이와 성별로 그룹 나누기 (이름도 같이 출력)
select name,
	   case when age like '1%' then '10대'
	   		when age like '2%' then '20대' end '나이 그룹',
	   case when gender ='male' then '남자'
	   		else '여자' end '성별 그룹'
from customers
where age between 10 and 29
order by age,gender
스파르타 답안
select case when age between 10 and 19 and gender = 'male' then '10대 남성'
			when age between 10 and 19 and gender = 'female' then '10대 여성'
			when age between 20 and 29 and gender = 'male' then '20대 남성'
			when age between 20 and 29 and gender = 'female' then '20대 여성' end '고객 분류',
			name,
			age,
			gender
from customers
where age between 10 and 29
출력 : name,10대 남성

3-5 [실습 2 ] (시청 전 먼저 구현해본 것)
select case when price between 5000 and 14999 and cuisine_type = 'Korean' then '저렴한식'
			when price  between 15000 and 20000 and cuisine_type = 'Korean' then '기본한식'
			when price between 20001 and 30000 and cuisine_type = 'Korean' then '고급한식'
			when price between 5000 and 14999 and cuisine_type in('Chinese','Japanese','Thai','Vietnamese','Indian') then '저렴 아시아식'
			when price  between 15000 and 20000 and cuisine_type in('Chinese','Japanese','Thai','Vietnamese','Indian')  then '기본 아시아식'
			when price between 20001 and 30000 and cuisine_type in('Chinese','Japanese','Thai','Vietnamese','Indian')  then '고급 아시아식'
			else '기타' end '음식점 분류',
			restaurant_name
from food_orders
where price between 5000 and 30000
스파르타 답안
select case when price/quantity  < 5000 and cuisine_type = 'Korean' then '저렴한식'
			when price/quantity  between 5000 and 15000 and cuisine_type = 'Korean' then '기본한식'
			when price/quantity >15000 and cuisine_type = 'Korean' then '고급한식'
			when price/quantity < 5000 and cuisine_type in('Chinese','Japanese','Thai','Vietnamese','Indian') then '저렴 아시아식'
			when price/quantity  between 5000 and 15000 and cuisine_type in('Chinese','Japanese','Thai','Vietnamese','Indian')  then '기본 아시아식'
			when price/quantity >15000 and cuisine_type in('Chinese','Japanese','Thai','Vietnamese','Indian')  then '고급 아시아식'
			else '기타' end '음식점 분류',
			restaurant_name
from food_orders
where price between 0 and 30000

실습[1] 조건문으로 서로 다른 식을 적용한 수수료 구해보기
지역과 배달시간을 기반으로 배달 수수료 구하기(식당 이름, 주문 번호 함께 출력)
(지역:서울,기타 - 서울일 때는 시간 계산 * 1.1 기타일 때는 곱하는 값 없음
시간 : 25분, 30분 - 25분 초과하면 음식 가격의 5%, 30분 초과하면 음식 가격의 10%)
(시청 전 구현해본것)
select case when addr like '%서울%' then '서울'
			else '기타' end '지역',
		if (addr like '%서울%',delivery_time * 1.1,delivery_time) '배달시간',
		case when if (addr like '%서울%',delivery_time * 1.1,delivery_time) between 26 and 29 then price *1.05
			 when if (addr like '%서울%',delivery_time * 1.1,delivery_time) > 30 then price *1.1 
			 else price end '음식 가격',
			 restaurant_name,
			 order_id,
			 price,
			 delivery_time
from food_orders
(스파르타 답안) 틀렸다고 생각함. 서울일 경우 delivery_time을 늘려서 계산해야하는데 pirce를 1.1곱하심
select		order_id,
			restaurant_name,
			substr(addr,1,2),
			delivery_time,
			price,
			case when delivery_time >30 then price * 0.1 *if(addr like '%서울%',1.1,1)
			when delivery_time >25 then price * 0.05 *if(addr like '%서울%',1.1,1)
			else 0 end '수수료'
from food_orders
(직접 수정해본)
select		order_id,
			restaurant_name,
			substr(addr,1,2),
			delivery_time,
			price,
			case when delivery_time*if(addr like '%서울%',1.1,1) >30 then price * 0.1 
			when delivery_time*if(addr like '%서울%',1.1,1) >25 then price * 0.05 
			else 0 end '수수료'
from food_orders

실습[2] 
주문 시기와 음식 수를 기반으로 배달 할증료 구하기
(주문 시기 : 평일 기본료 = 3000/ 주말 기본료 = 3500, 
음식 수 : 3개 이하이면 할증 없음/3개 초과이면 기본료 * 1.2)
(시청 전 구현해본것)
select case when day_of_the_week = 'weekday' then 3000 * if(quantity>3,1.2,1)
			when day_of_the_week = 'weekend' then 3500 * if(quantity>3,1.2,1)
			end '요금표',
			restaurant_name,
			day_of_the_week,
			quantity
from food_orders
Subquery 예시
select order_id, restaurant_name, if(over_time>=0, over_time, 0) over_time
from 
(
select order_id, restaurant_name, food_preparation_time-25 over_time
from food_orders
) a

4-3 Subquery 연습1
[실습 1]
음식점의 평균 단가별 segmentatino을 진행하고, 그룹에 따라 수수료 연산하기
(수수료 구간 - 
~5000원 미만 0.05%
~20000원 미만 1%
~30000원 미만 2%
30000원 초과 3%)
(시청 전 구현해본것)
select  restaurant_name,
		unit_price+unit_price*vat vat_price
from
(
SELECT restaurant_name,
	   unit_price,
  	   case when unit_price < 5000 then  0.005
	   		when unit_price < 20000 then   0.01
	   		when unit_price < 30000 then   0.02
	   		when unit_price > 30000 then   0.03 end vat
from 
(
select restaurant_name,
avg(price/quantity) unit_price
from food_orders fo
group by price/quantity
) a
) b
(영상 속 답안)
select restaurant_name,
       price_per_plate*ratio_of_add "수수료"
from 
(
select restaurant_name,
       case when price_per_plate<5000 then 0.005
            when price_per_plate between 5000 and 19999 then 0.01
            when price_per_plate between 20000 and 29999 then 0.02
            else 0.03 end ratio_of_add,
       price_per_plate
from 
(
select restaurant_name, avg(price/quantity) price_per_plate
from food_orders
group by 1
) a
) b

[실습 2]
음식점의 지역과 평균  배달시간으로 segmentation하기
(지역 앞 두글자 사용,
평균 배달시간은 20분 30분 30분 초과)
(시청 전 구현해본 것)
select sido,
	   case when avg_delivery_time <= 20 then '빠르군'
			when avg_delivery_time < 30 then '준수하군'
			when avg_delivery_time >= 30 then '느리군' end '지역 배달 수준'
from
(
select substr(addr,1,2) sido,
	   avg(delivery_time) avg_delivery_time
from food_orders
group by 1
) a




(영상 속 답안) 틀렸다고 생각함 = avg가 필요가 없음 애초에 지역의 평균 배달로 가는게 맞는걸로 판단됨
SELECT restaurant_name,
addr_first,
	   case when avg_delivery_time <= 20 then '빠르군'
			when avg_delivery_time < 30 then '준수하군'
			when avg_delivery_time >= 30 then '느리군' end '지역 배달 수준'
FROM 
(
select restaurant_name,
	   substr(addr,1,2) addr_first,
	   avg(delivery_time) avg_delivery_time
from food_orders fo
group by 1,2
) a


4-4 subquery 연습 2
[실습 1] 음식 타입별 지역별 총 주문수량과 음식점 수를 연산하고,
주문수량과 음식점수 별 수수료율을 산정하기
(음식점 수 5개 이상, 주문수 30개 이상 -> 수수료 0.05%
음식점 수 5개 이상, 주문수 30개 미만 -> 수수료 0.08%
음식점수 5개 미만, 주문수 30개 이상 -> 수수료 1%
음식점수 5개 이상, 주문수 30개 미만 -> 수수료 2%)
(시청 전 구현해본 것)
SELECT cuisine_type,
	   sido,
	   sum_quantity,
	   count_store,
	   case when count_store >= 5 and sum_quantity >= 30 then 0.005
			when count_store >= 5 and sum_quantity < 30 then 0.008
			when count_store < 5 and sum_quantity >= 30 then 0.01	
			when count_store < 5 and sum_quantity < 30 then 0.02
			end '수수료'
FROM 
(
SELECT  cuisine_type,
		SUBSTR(addr,1,2) sido,
		sum(quantity) sum_quantity,
		count(restaurant_name) count_store
FROM food_orders fo 
group by 1,2
) a

(영상 속 답안) 이건 마치.. 음식 타입별 총 주문 수량과 음식점! 이름 수!를 연산하고
주문수량과 음식점 !이름 수! 별 수수료율을 산정하기 이런걸 하신것과 같지 않나 생각해봅니다.
select cuisine_type,
	   total_quantity,
	   count_res_name,
	   case when count_res_name >= 5 and total_quantity >= 30 then 0.005
			when count_res_name >= 5 and total_quantity < 30 then 0.008
			when count_res_name < 5 and total_quantity >= 30 then 0.01	
			when count_res_name < 5 and total_quantity < 30 then 0.02
			end '수수료'
from
(
select cuisine_type,
	   sum(quantity) total_quantity,
	   count(distinct restaurant_name) count_res_name
from food_orders
group by 1
) a

[실습 2] 음식점의 총 주문수량과 주문 금액을 연산하고, 주문 수량을 기반으로 수수료 할인율 구하기
(할인조건
수량이 5개 이하 -> 10%
수량이 15개 초과, 총 주문금액이 300000이상 -> 0.5%
이 외에는 일괄 1%)
(시청 전 구현해본것)
SELECT restaurant_name,
	   total_quantity,
	   total_price,
	   case when total_quantity <= 5 then 0.1 
	   		when total_quantity > 15 and total_price >= 300000 then 0.005
	   		else 0.01 end '수수료 할인율'
FROM 
(
SELECT restaurant_name,
	   sum(quantity) total_quantity,
	   sum(price) total_price
from food_orders
group by 1
) a
(영상 속 답안)
= 동일 !!




Join
A left join B = A table 정보는 다 가져오고 B table 정보는 교집합 부분만 가져온다 
(B가 해당 없는 부분은 Null로 출력)  
A inner join B = A table과 B table 교집합만 출력
실행 방식 = A ~ join B on A.cullom = B.cullom 

4-6 Join문 연습
[실습 1] 한국 음식의 주문별 결제 수단과 수수료율을 조회하기
(시청 전 구현해본 것)
select f.cuisine_type,
	   f.order_id,
	   f.restaurant_name,
	   f.price,
	   p.pay_type,
	   f.rating
from food_orders f left join payments p on f.order_id = p.order_id 
where cuisine_type = 'Korean'
(영상 속 답안)
select f.order_id,  
	   f.restaurant_name,
	   f.price,
	   p.pay_type,
	   p.vat
from food_orders f left join payments p on f.order_id = p.order_id 
where cuisine_type = 'Korean'

[실습 2] 고객의 주문 식당 조회하기
( 조회 컬럼 : 고객 이름, 연령, 성별, 주문 식당)
고객명으로 정렬,중복 없도록 조회
(시청 전 구현해본 것)
select c.name,
	   c.age,
	   c.gender,
	   f.restaurant_name
from customers c left join food_orders f on c.customer_id = f.customer_id
group by c.name
order by c.name
(영상 속 답안)
select distinct c.name,
	   c.age,
	   c.gender,
	   f.restaurant_name
from customers c left join food_orders f on c.customer_id = f.customer_id
order by c.name


4-7 join 연산
[실습1] 주문 가격과 수수료율을 곱하여 주문별 수수료 구하기
(조회 컬럼 : 주문 번호, 식당 이름, 주문 가격, 수수료율, 수수료)
* 수수료율이 있는 경우만 조회
(시청 전 구현해본 것)
select f.order_id,
	   f.restaurant_name,
	   f.price,
	   p.vat,
	   f.price * vat '주문별 수수료'
from food_orders f inner join payments p on f.order_id = p.order_id 

[실습 2] 50세 이상 고객의 연령에 따라 경로 할인율을 적용하고, 
음식 타입별로 원래 가격과 할인 적용 가격 합을 구하기
(조회 컬럼 : 음식 타입, 원래 가격, 할인 적용 가격, 할인 가격)
* 할인 : 나이 -50*0.005
* 고객 정보가 없는 경우도 포함하여 조회, 할인 금액이 큰 순서대로 정렬
(시청 전 구현해본 것)
SELECT f_cui_type,
	   f_price,
	   case when  c_age >= 50 then f_price - (c_age - 50 * 0.005) end '할인 적용가격',
	   case when  c_age >= 50 then (c_age - 50 * 0.005) end '할인 가격'
FROM 
(
SELECT f.cuisine_type f_cui_type,
	   f.price f_price,
	   c.age c_age
from food_orders f left join customers c on f.customer_id = c.customer_id 
) a
(실제 답안)
SELECT cuisine_type '음식 타입',
	   sum(price) '원래 가격',
	   sum(price)-sum(discount) '할인 적용 가격',
	   sum(discount) '할인 가격'
FROM 
(
SELECT f.cuisine_type,
	   price,
	   price*((c.age-50)*0.005) discount
from food_orders f inner join customers c on f.customer_id = c.customer_id
where c.age >= 50
) a
group by 1
order by 4 DESC 

(영상 속 답안) // 틀렸죠. . . 제가 맞았죠
SELECT cuisine_type,
	   sum(price) price,
	   sum(price*discount_rate) discounted_price
FROM 
(
SELECT f.cuisine_type,
	   f.price,
	   (c.age-50)*0.005 discount_rate
from food_orders f inner join customers c on f.customer_id = c.customer_id
where c.age >= 50
) a
group by 1
order by 3 DESC 

4주차 숙제
답안! 정답!
SELECT restaurant_name,
	   case when avg_price <= 5000 then 'price_group1'
			when avg_price <= 10000 then 'price_group2'
			when avg_price <= 30000 then 'price_group3'
			when avg_price > 30000 then 'price_group4' end 'price_group',
	   case when avg_age < 30 then 'age_group1'
	   		when avg_age between 30 and 39 then 'age_group2'
	   		when avg_age between 40 and 49 then 'age_group3'
	   		when avg_age >= 50 then 'age_group4' end 'age_group'
FROM 
(
SELECT f.restaurant_name,
	   avg(f.price)avg_price,
	   avg(c.age) avg_age
from food_orders f inner join customers c on f.customer_id = c.customer_id 
group by 1
) a

조회한 데이터가 잘못된값(상식적이지 않은 값을 가질때)

select restaurant_name,
	   avg(rating),
	   avg(if(rating<>'Not given',rating,null))
from food_orders
group by 1



5-2 값의제외

order by 1
select a.order_id,
       a.customer_id,
       a.restaurant_name,
       a.price,
       b.name,
       b.age,
       b.gender
from food_orders a left join customers b on a.customer_id=b.customer_id
where b.customer_id is not null  // inner join과 유사한 효과

값의 변경
select a.order_id,
       a.customer_id,
       a.restaurant_name,
       a.price,
       b.name,
       b.age,
       coalesce(b.age, 20) "null 제거", // coalesce(column,b) coulumn에 null값이 있으면 b로 반환해줘
       b.gender
from food_orders a left join customers b on a.customer_id=b.customer_id
where b.age is null




5-3
상식적이지 않은 값에 대해 대응
SELECT customer_id,
	   name,
	   email,
	   gender,
	   age,
	   case when age < 15 then 15 
	   		when age > 80 then 80
	   		else age end age
FROM customers c 

5-4 SQL로 Pivot table 만들어보기 
[실습] 음식점별 시간별 주문건수 Pivot Table 뷰 만들기 
(15~20사이, 20시 주문건수 기준 내림차순)
기준이 될 서브쿼리 작성
(시청 전 구현해본것)
select f.restaurant_name,
	   substr(p.time,1,2),
	   count(p.time)
from food_orders f inner join payments p  on f.order_id = p.order_id 
where substr(p.time,1,2) between 15 and 20 
group by 1,2
(답안)
select a.restaurant_name,
       substring(b.time, 1, 2) hh,
       count(1) cnt_order
from food_orders a inner join payments b on a.order_id=b.order_id
where substring(b.time, 1, 2) between 15 and 20
group by 1, 2

pivot view 
SELECT restaurant_name,
	   max(if(hh = '15', cnt_order,0)) '15',
	   max(if(hh = '16', cnt_order,0)) '16',
	   max(if(hh = '17', cnt_order,0)) '17',
	   max(if(hh = '18', cnt_order,0)) '18',
	   max(if(hh = '19', cnt_order,0)) '19',
	   max(if(hh = '20', cnt_order,0)) '20'
FROM 
(
select f.restaurant_name,
	   substr(p.time,1,2) hh,
	   count(1) cnt_order
from food_orders f inner join payments p on f.order_id = p.order_id
where substr(p.time,1,2) between 15 and 20
group by 1,2
) a
group by 1
order by 7 desc
(영상 속 답안)
select restaurant_name,
       max(if(hh='15', cnt_order, 0)) "15",
       max(if(hh='16', cnt_order, 0)) "16",
       max(if(hh='17', cnt_order, 0)) "17",
       max(if(hh='18', cnt_order, 0)) "18",
       max(if(hh='19', cnt_order, 0)) "19",
       max(if(hh='20', cnt_order, 0)) "20"
from 
(
select a.restaurant_name,
       substring(b.time, 1, 2) hh,
       count(1) cnt_order
from food_orders a inner join payments b on a.order_id=b.order_id
where substring(b.time, 1, 2) between 15 and 20
group by 1, 2
) a
group by 1
order by 7 desc

[실습 2] 성별, 연령별 주문건수 Pivot Table 뷰 만들기
(나이는 10~59세 사이, 연령 순으로 내림차순)
(시청 전 구현해본 것)
select age,
	   max(if(gender = 'male',cnt_gender,0)) 'male',
	   max(if(gender = 'female',cnt_gender,0)) 'female'
from
(
select c.gender,
       case when c.age between 10 and 19 then '10'
       		when c.age between 20 and 29 then '20'
       		when c.age between 30 and 39 then '30'
       		when c.age between 40 and 49 then '40'
       		when c.age between 50 and 59 then '50' end age_segment age,
       count(c.age) cnt_gender
from customers c inner join food_orders f on c.customer_id = f.customer_id 
where c.age between 10 and 59
group by 1,2
) a
group by 1
order by 1 desc
(영상속 답안)
select age,
       max(if(gender='male', order_count, 0)) male,
       max(if(gender='female', order_count, 0)) female
from 
(
select b.gender,
       case when age between 10 and 19 then 10
            when age between 20 and 29 then 20
            when age between 30 and 39 then 30
            when age between 40 and 49 then 40
            when age between 50 and 59 then 50 end age,
       count(1) order_count
from food_orders a inner join customers b on a.customer_id=b.customer_id
where b.age between 10 and 59
group by 1, 2
) t
group by 1
order by age

5-5 업무 시작을 단축시켜 주는 마법의 문법 (Window Function - RANK, SUM)
[실습1] 음식 타입별로 주문 건수가 가장 많은 상점 3개씩 조회하기
SELECT cuisine_type,
	   restaurant_name,
	   cnt_order,
	   rank_order
FROM 
(
select cuisine_type,
	   restaurant_name,
	   cnt_order,
	   rank() over (partition by cuisine_type order by cnt_order desc) rank_order
from
(
select cuisine_type,
	   restaurant_name,
	   count(1) cnt_order
from food_orders fo
group by 1,2
) a
) b
where rank_order <= 3

[실습 2]각 음식점의 주문건이 해당 음식 타입에서 차지하는 비율을 구하고, 
주문건이 낮은 순으로 정렬했을 때 누적 합 구하기
SELECT cuisine_type,
	   restaurant_name,
	   cnt_order,
	   sum(cnt_order) over (partition by cuisine_type),
	   sum(cnt_order) over (partition by cuisine_type order by cnt_order)
from
(
select cuisine_type,
	   restaurant_name,
	   count(1) cnt_order
from food_orders
group by 1,2
)a


(진짜 말대로 음식타입에서 비율 구하고 비율 순위까지 구하기)
SELECT cuisine_type,
	   restaurant_name,
	   cnt_order,
	   percent,
	   rank() over(order by percent desc)
FROM 
(
SELECT cuisine_type,
	   restaurant_name,
	   cnt_order,
	   cnt_order/sum_cuisine_type_group percent,
	   sum(cnt_order) over(partition by cuisine_type order by cnt_order) '누적합'
FROM
(
SELECT cuisine_type,
	   restaurant_name,
	   cnt_order,
	   sum(cnt_order) over(partition by cuisine_type) sum_cuisine_type_group
FROM 
(
SELECT cuisine_type,
	   restaurant_name,
	   count(1) cnt_order
FROM food_orders fo 
group by 1,2
) a
) b
) c







