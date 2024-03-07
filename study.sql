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