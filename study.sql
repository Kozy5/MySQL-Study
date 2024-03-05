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

2.between A and B  // A부터 B까지 값
where age between 21 and 23 // age에 21부터23까지의 값만 뽑아줘
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



