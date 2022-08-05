# MyNewExampleTest

#하고자 했던 것
1. mvvm + rx + input, output 적용 -> 잘 되지 않아서 input,output없이 구현
2. coordinator 패턴적용 -> 흐름이 눈에 잘 안들어와서, 내가 코드를 이상하게 짜고있음. 개선필요
3. DI적용 
4. RxAlamofire로 Error 핸들링 처리 -> Drive를 사용하여 error를 못받는 상황 -> 검색해보고 적용예정


#궁금한 사항
1. network 모델 관련 질문
2. Webview ATS관련 질문
3. tableviwe cell내 버튼 클릭 rx로 처리.?
4. 즐겨찾기 뷰컨트롤러 즐겨찾기 해제 -> 검색화면 tableview reload방법



1. Network 통신 모델을 만들때, 받아온 데이터를 그대로 사용을 하는 경우는 struct?  
그렇지 않고 중간에 받아온 데이터를 우리가 원하는 형태로 변형이 필요한 경우에는 class?  
받아온 데이터를 struct로 받은 다음에 그 struct를 원하는 곳에서 새롭게 만들고 값을 변경하는 형태로 사용을 하는지.?  
함수로 받는 경우에(rx) 상수로 받기 때문에 struct의 경우 데이터 수정이 불가능한데, class의 경우에는 가능할 것 같아서 이렇게 사용하는게 맞는지  

2. Webview 관련 ATS설정을 어떻게 해야하는지.?  
예외적인 baseURL을 허용해주고 싶었고 지정을 하였느데 흰화면만 보였다.  
모두 허용을 통해서 웹뷰가 나오도록 설정을 했는데 이게 맞지 않는 것 같다.  


3. 셀의 버튼을 클릭 -> 어떤 결과가 리턴(셀의 값을 같이 전달)  
Input -> output을 어떻게 적용을 해야할지 정확하게 모르겠음.  
Output으로 셀의 아이템을 어떻게 전달할 수 있을까.?   
cellForRawAt에서 bind를 해주는 것이 맞을까>??

4. 즐겨찾기, 상세화면에서 복귀시, tablewview를 뷰컨의 생명주기를 통해서 리로드해주는데  
즐겨찾기의 즐겨찾기 버튼 클릭시 데이터를 방출해서 tableView에 전달해주고 싶은데 처리를  못하였다.  

