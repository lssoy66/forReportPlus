## 논문/리포트 구매 사이트 forReport
> 중앙 팀 프로젝트 4팀의 콘텐츠 쇼핑몰 구현 프로젝트입니다.
* 프로젝트 시작일 : 12.31
* 프로젝트 종료일 : 2.2

---

### 개발환경
* OS : Window 10
* Library : JDK 1.8, ojdbc6
* Server : Apache Tomcat 9.0
* Application Framework : Spring 5.0.7
* Database : Oracle 11g
* IDE : Eclipse
* Build Automation Tool : Maven
* Back-Language : JAVA(Spring, MyBatis), JSP, 
* Front-Language : HTML5, CSS3, Bootstrap, jQuery, JavaScript, JSON, Ajax

---

### 팀원과 각 역할
|팀원|역할|
|---|----------|
|이수연(팀장)|장바구니, 주문결제, 관리자(주문), 구매내역 및 판매내역, 결제 REST API|
|김조은|회원가입/수정/탈퇴, 회원 정보 조회, 관리자(회원), 아이디/비밀번호 찾기|
|윤성헌|시큐리티 로그인/로그아웃, 암호화, 공지사항, 자주묻는질문, 관리자(공지사항, 자주묻는질문)|
|이은지|메인 페이지, 상품 등록/수정/삭제, 자동 썸네일 생성, 관리자(상품), 승인 요청 처리|

---

### 협업 규칙(필독)
* 작업하기 전, develop 브랜치에 commit 사항이 존재할 수도 있기 때문에 반드시 pull부터 하고 작업하기
* __pull 할 때는 반드시! develop 브랜치로 바꾼 후 pull__
* pom.properties, manifest.mf 파일과 maven update 시 추가되는 모든 파일들은 assume unchanged 해두고 push할 때 넘기지 않도록 주의하기
* commit and push 할 때는 본인이 생성한 브랜치(feature)에 하기
* Pull Request Merge는 코드 리뷰를 모두 받고, 마지막 코드 리뷰를 남긴 사람이 Merge
* 작업한 내용을 develop 브랜치에 Merge했으면, 작업하던 feature 브랜치는 삭제하고 현재 모든 상태가 저장된 develop에서 새로운 feature 브랜치 생성하여 사용하기
(삭제할 때는 원격 저장소, 로컬 저장소 양 쪽 모두에서 삭제하기)
* Commit Message는 아래와 같은 규칙으로 작성(알아보기 쉽도록 하기 위해서)
  + 추가 : [add] 추가한 내용...
  + 수정 : [update] 수정한 내용...

---

새로운 내용은 아래에 추가합니다.
