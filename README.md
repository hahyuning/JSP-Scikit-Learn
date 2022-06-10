# JSP-Scikit-Learn

## Issue
JSP를 이용한 사용자에게 역대 흥행한 영화들과 개봉 예정인 영화들에 대한 정보를 제공하는 사이트입니다.
또한 텍스트 분석을 통해 각 영화에 대해 해당 영화와 유사한 영화를 추천해주는 기능을 구현했습니다.
<br><br>

#### 참여 인원: 3명

#### 사용 기술
+ Java, MySQL, JDBC, JSP, Ajax, JQuery
+ Python, Selenium, Scikit-Learn

#### 맡은 역할
+ 회원가입, 로그인, 계정 관리 기능
+ 크롤링을 이용한 개봉 예정인 영화 데이터 수집
+ 역대 흥행 영화 순위별 정보 출력
+ 텍스트 분석을 통한 유사 영화 추천 기능
<br>

## Problem & Solution
개봉 예정 영화 페이지를 만들 때 개봉일별로 모든 영화를 가져온 후 화면에 6개씩 출력하고, 만약 해당 개봉일의 영화가 6개 이상인 경우 이전, 다음 버튼을 이용하여 다음 영화를 확인할 기능을 구현하려고 했습니다. 또한 더이상 넘어갈 수 없는 경우에는 버튼을 출력하지 않게 만들고 싶었습니다. 하지만 개봉일마다 영화의 수가 달랐고 영화의 수도 6의 배수가 아니었기 때문에 모든 개봉일에 대해 하나로 처리하는 함수를 만들기가 어려웠습니다. <br>
이러한 문제를 해결하기 위해 그 당시에는 자바스크립트의 자료구조 중 배열 2개를 이용했습니다. 한쪽 배열엔 이전 영화들을 포함헤서 화면에 출력될 영화들을 저장하고 다른 배열에는 다음 영화들을 저장해서 이전, 다음 버튼을 누를때마다 6개씩 영화들이 두 배열을 왔다갔다 하도록 구현했습니다. 또한 배열에 남아있는 영화들의 갯수를 계산해서 버튼의 출력 여부도 지정했습니다. <br>

이후 스프링에 대해 더 공부하고 난 후 다시 생각해보니 그 당시 해결했던 방법이 정말 효율적일까?? 만약 가져와야 하는 영화의 수가 많다면?? 이라는 생각이 들었습니다. 
만약 다시 해당 기능을 구현한다면 이전, 다음 버튼을 누를때마다 영화의 페이지 번호를 넘겨서 DB에 이전 또는 다음 영화 6개를 요청하는 쪽으로 구현할 것 같습니다. 또한 JPA의 paging 기능도 적용해보고 싶습니다.

<br>

## What I Learn
프로젝트를 통해 서버에 요청을 하고 응답을 받을 때 다른 페이지로 전환되는 방식이 아닌, 해당 화면에서 필요한 부분만 바꾸는 비동기 요청에 대해 배울 수 있었습니다. 또한 텍스트 분석을 하면서 데이터 전처리가 얼마나 중요한지에 대해 배울 수 있었습니다. 조사나 접속사, 접미사와 같은 불용어 처리를 하지 않고 텍스트 분석 진행 시 30%에 그쳤던 유사도를 전처리 이후 70% 가까이로 올릴 수 있었습니다.

<br>
<br>

![포트폴리오-이하현-48-1](https://user-images.githubusercontent.com/60869749/132088643-66ce8f03-9156-4c61-ab17-32cfec9ba652.jpg)
![포트폴리오-이하현-49-1](https://user-images.githubusercontent.com/60869749/132088645-3173d40a-1d83-4bd4-98fd-a8bbd62539c4.jpg)
![포트폴리오-이하현-50-1](https://user-images.githubusercontent.com/60869749/132088646-eb907d59-854f-4b92-b57f-0d8d62f87040.jpg)
![포트폴리오-이하현-51-1](https://user-images.githubusercontent.com/60869749/132088658-e18a1837-2feb-4ace-ae9f-7b7ed4dd4954.jpg)
![포트폴리오-이하현-52-1](https://user-images.githubusercontent.com/60869749/132088661-ac056d44-dde3-4f83-926a-72e21be59523.jpg)
![포트폴리오-이하현-53-1](https://user-images.githubusercontent.com/60869749/132088662-a53037dd-c727-4b5a-8a8b-86caaa8cbab6.jpg)
![포트폴리오-이하현-54-1](https://user-images.githubusercontent.com/60869749/132088665-211e1ccf-7ea4-4e0e-ad5f-11934e057804.jpg)
![포트폴리오-이하현-55-1](https://user-images.githubusercontent.com/60869749/132088666-bbe5c3d5-201f-4e81-8136-c4f7f2293c4d.jpg)
![포트폴리오-이하현-56-1](https://user-images.githubusercontent.com/60869749/132088668-2afda1d5-699d-4612-ae47-28f1f926026d.jpg)
![포트폴리오-이하현-57-1](https://user-images.githubusercontent.com/60869749/132088670-4b038521-498b-4207-8594-5922b06609a8.jpg)
![포트폴리오-이하현-58-1](https://user-images.githubusercontent.com/60869749/132088672-1a46ebf1-1bfb-4e73-b6b1-186f3ed0eb00.jpg)
![포트폴리오-이하현-59-1](https://user-images.githubusercontent.com/60869749/132088674-6f454e9a-b7ed-4346-9873-7cba8a95501e.jpg)
![포트폴리오-이하현-60-1](https://user-images.githubusercontent.com/60869749/132088677-c26006e5-029c-41a5-98f7-df748714b47c.jpg)
![포트폴리오-이하현-61-1](https://user-images.githubusercontent.com/60869749/132088679-5ed2fe7a-1ae1-41a8-bae0-9105b8afb0db.jpg)

