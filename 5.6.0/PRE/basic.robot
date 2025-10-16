*** Settings ***
Library    AppiumLibrary
Library    Process
Library    OperatingSystem

Resource    mBtv.resource
Suite Setup    앱 실행
Test Setup    앱 종료 후 재진입


*** Test Cases ***

56678 찜 목록 카드 확인
    #1. 앱 실행 > "MY" > 찜 목록 진입    /    1. '찜 목록은 60개까지 저장됩니다.' 문구 노출 확인
    #2. 임의의 포스터 선택하여 시놉시스 진입    /    2. VOD 타이틀 노출 확인 시 pass

    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skb.smartrc:id/iv_my
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.widget.TextView[@text="찜 목록"]
    Sleep    1
    Element Text Should Be    com.skb.smartrc:id/tv_title_comment    찜 목록은 60개까지 저장됩니다.
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.widget.ImageView[@resource-id="com.skb.smartrc:id/iv_favorite_poster"]
    Sleep    1
    Wait Until Element Is Visible    com.skb.smartrc:id/tv_title

56677 TV다시보기 콘텐츠 전체 가격 표기 삭제 확인
    #1. 앱 실행 > "탐색" > TV 보기 진입
    #2. 아래로 스크롤 하면서 가격 미노출 확인    /    2. 스크롤 끝날 때까지 가격(0원)이 포함된 엘리먼트 노출되지 않을 시 pass

    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.view.ViewGroup[@content-desc="탐색버튼"]
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.view.ViewGroup[@content-desc="TV 방송버튼"]
    Sleep    1
    FOR  ${i}  IN RANGE    0    10    #아래로 스크롤 하면서 가격이 노출되지 않는 지 확인
        Page Should Not Contain Element    Xpath=//android.widget.TextView[contains(@text, "0원")]
        Swipe By Percent    50    70    50    30
    END

56668 카테고리_진입 정책 확인 (ZEM키즈)
    #1. 앱 실행 > "탐색" > ZEM 진입    /    1. ZEM키즈 홈 노출 확인 시 pass

    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.view.ViewGroup[@content-desc="탐색버튼"]
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.view.ViewGroup[@content-desc="ZEM버튼"]
    Sleep    1
    Wait Until Element Is Visible    Xpath=//android.widget.ImageView[@content-desc="홈"]
    
56665 Navigation Back_예외케이스 확인 (인물정보)
    #1. 앱 실행 > "탐색" > '클래식' 시놉시스 진입 > '조승우' 인물정보 이동 > 연관 콘텐츠 내 '신성한, 이혼' 진입    
    #2. Back(<) 키 입력    /    2. 첫 진입 콘텐츠인 '클래식' 시놉시스로 이동 시 pass 

    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.view.ViewGroup[@content-desc="탐색버튼"]
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skb.smartrc:id/et_search_bar
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Input Text    com.skb.smartrc:id/top_search_bar    범죄도시 2
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.widget.TextView[@text = '범죄도시 2']
    Sleep    2

    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.view.ViewGroup[@content-desc="범죄도시 2"]
    Sleep    1
    Swipe By Percent    50    70    50    30
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.widget.TextView[@text = "마동석"]
    Sleep    1
    Swipe By Percent    50    70    50    30
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.view.ViewGroup[@content-desc="압꾸정"]
    Sleep    1
    Wait Until Element Is Visible    Xpath=//android.widget.TextView[@text = "압꾸정"]
    Press Keycode    4    #Back 키 입력
    Sleep    1
    Wait Until Element Is Visible    Xpath=//android.widget.TextView[@text = "범죄도시 2"]

56669 카테고리 구성 확인
    #1. "탐색" > 카테고리 내 "공개예정" 진입    /    1. "공개예정" 타이틀 노출 확인
    #2. "탐색" > 카테고리 내 "이벤트" 진입    /    2. "이벤트" 타이틀 노출 확인 시 pass

    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.view.ViewGroup[@content-desc="탐색버튼"]
    Sleep    1
    Swipe By Percent    50    70    50    30
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.view.ViewGroup[@content-desc="공개예정버튼"]
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Wait Until Element Is Visible    Xpath=//android.widget.TextView[@text="공개예정"]
    Press Keycode    4
    Sleep    1

    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.view.ViewGroup[@content-desc="이벤트버튼"]
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Wait Until Element Is Visible    Xpath=//android.widget.TextView[@text="이벤트"]
    
56645 월정액 화면 내 기간권 이용중 문구 노출 확인
    #0. CJ ENM 월정액 가입 상태
    #1. 앱 실행 > "홈" > 퀵메뉴 내 "월정액" 진입
    #2. 가입된 월정액 선택(CJ ENM) > 안내문구 확인    /    2. '아래의 모든 콘텐츠를 마음껏 즐겨보세요!' 문구 확인 시 pass

    FOR  ${i}  IN RANGE    0    10    #월정액 퀵메뉴 노출시점까지 스크롤
        Swipe By Percent    50    70    50    30
        ${pass}    Run Keyword And Return Status    Wait until Element Is Visible    Xpath=(//android.widget.ImageView[@resource-id="com.skb.smartrc:id/iv_icon"])[2]
        Exit For Loop If    ${pass}
    END
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=(//android.widget.ImageView[@resource-id="com.skb.smartrc:id/iv_icon"])[2]
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.widget.RelativeLayout[@content-desc="CJ ENM 월정액"]
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Wait Until Element Is Visible    Xpath=//android.widget.TextView[@text="아래의 모든 콘텐츠를 마음껏 즐겨보세요!"]

56621 ZEM 검색어 입력 동작
    #1. 앱 실행 > "탐색" > "잼키즈" > 검색버튼 선택
    #2. 검색어 미 입력 상태에서 검색 아이콘 선택    /    2. 검색어 미입력 안내 팝업 노출 확인
    #3. 검색어('ㄱ') 입력    /    3. 자동완성 영역 노출 확인
    #4. 삭제(x) 버튼 입력    /    4. text 삭제 후 검색 필드에 '검색어를 입력해주세요' 문구 노출 확인
    #5. 검색어('ㄱ') 재입력 후 검색버튼 선택    /    5. 검색결과 페이지 이동 확인 시 pass (VOD블록 노출 확인)
    
    탐색 > ZEM 진입
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skb.smartrc:id/iv_search    #검색버튼
    Sleep    1

    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skb.smartrc:id/top_search_icon    #검색어 미입력 상태에서 검색 버튼
    Sleep    1
    Element Text Should Be    com.skb.smartrc:id/tv_title    검색어를 입력해주세요.    #팝업 문구 확인
    Sleep    1 
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.widget.Button[@text="확인"]    #팝업 닫기
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skb.smartrc:id/top_search_bar
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Input Text    com.skb.smartrc:id/top_search_bar    ㄱ
    Sleep    1
    Wait Until Element Is Visible    com.skb.smartrc:id/top_search_bar_auto_complete    #자동완성 결과 노출 확인

    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skb.smartrc:id/top_search_remove
    Sleep    1
    Element Text Should Be    com.skb.smartrc:id/top_search_bar    검색어를 입력해주세요.
    Sleep    1

    Wait Until Keyword Succeeds    1 min    3 sec    Input Text    com.skb.smartrc:id/top_search_bar    ㄱ
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skb.smartrc:id/top_search_icon
    Sleep    1
    Wait Until Element Is Visible    Xpath=//android.widget.TextView[@resource-id="com.skb.smartrc:id/title" and @text="VOD"]

56620 ZEM 검색어 자동완성
    #1. 앱 실행 > "탐색" > "잼키즈" > 검색버튼 선택
    #2. 검색어 '뽀로로' 입력    /    2. 자동완성 목록 6개 노출 확인
    #3. 검색어 '타짜' 입력    /    3. 자동완성 영역 미 노출 시 pass
    
    탐색 > ZEM 진입
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skb.smartrc:id/iv_search    #검색버튼
    Sleep    1
    Wait Until Element Is Visible    com.skb.smartrc:id/top_search_bar
    Wait Until Keyword Succeeds    1 min    3 sec    Input Text    com.skb.smartrc:id/top_search_bar    뽀로로
    Sleep    1
    #자동완성 목록
    Wait Until Element Is Visible    Xpath=//android.widget.TextView[@text="뽀로로"]
    Wait Until Element Is Visible    Xpath=//android.widget.TextView[@text="뽀로로와 노래해요"]
    Wait Until Element Is Visible    Xpath=//android.widget.TextView[@text="뽀로로톡 뽀롱뽀롱 한글나라"]
    Wait Until Element Is Visible    Xpath=//android.widget.TextView[@text="뽀로로의 올바른 생활습관"]
    Wait Until Element Is Visible    Xpath=//android.widget.TextView[@text="뽀로로 동화나라 동요"]
    Wait Until Element Is Visible    Xpath=//android.widget.TextView[@text="뽀로로TV"]

    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skb.smartrc:id/top_search_remove
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Input Text    com.skb.smartrc:id/top_search_bar    타짜
    Sleep    1
    Page Should Not Contain Element    com.skb.smartrc:id/top_search_bar_auto_complete    #자동완성 영역 미노출 확인

56628 키즈 전용 UI_gnb 상단 고정영역 기능 확인 (이용권,검색,나가기)
    #1. 앱 실행 > "탐색" > "잼키즈" > 상단 이용권 버튼 선택    /    1. 이용권 타이틀 노출 확인
    #2. 이전 키 > 상단 검색 버튼 선택    /    2. 검색바 노출 확인
    #3. 이전 키 > 상단 나가기 버튼 선택    /    3. 잼 진입 이전 탐색 화면 노출 확인 시 pass
    
    탐색 > ZEM 진입
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skb.smartrc:id/iv_ticket    #이용권 버튼
    Sleep    1
    Wait Until Element Is Visible    Xpath=//android.widget.TextView[@text="이용권"]
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skb.smartrc:id/iv_back
    Sleep    1

    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skb.smartrc:id/iv_search    #검색 버튼
    Sleep    1
    Wait Until Element Is Visible    com.skb.smartrc:id/top_search_bar
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skb.smartrc:id/top_back
    Sleep    1

    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skb.smartrc:id/iv_exit    #나가기 버튼
    Sleep    1
    Wait Until Element Is Visible    Xpath=//android.widget.TextView[@content-desc="탐색"]

56625 ZEM 키즈 종료
    #1. 앱 실행 > "탐색" > "잼키즈" > 프로필 > 인증번호 입력 후 설정 진입
    #2. ZEM 종료 인증 설정 ON > Back 키 3회 입력 > ZEM 종료 팝업 인증    /    2. 탐색 화면 이동 확인
    #3. ZEM 재 진입 > 프로필 > 인증번호 입력 후 설정 진입
    #4. ZEM 종료 인증 설정 OFF > Back 키 3회 입력    /    4. 탐색 화면 이동 확인 시 pass   
      
    탐색 > ZEM 진입    #ZEM 종료 인증 설정 ON
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skb.smartrc:id/rl_header_profile_info    #프로필 선택
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.widget.ImageView[@content-desc="설정"]
    Sleep    1
    성인인증번호(0000) 입력
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skb.smartrc:id/bt_right
    Sleep    1
    FOR  ${i}  IN RANGE    0    10    #My oksusu 소장 VOD 이용하기 노출시점까지 스크롤
        Swipe By Percent    50    70    50    30
        ${pass}    Run Keyword And Return Status    Wait until Element Is Visible    Xpath=//android.widget.TextView[@text="My oksusu 소장 VOD 이용하기"]
        Exit For Loop If    ${pass}
    END
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.widget.ScrollView/android.view.View[3]
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skb.smartrc:id/dialog_input
    Sleep    1
    성인인증번호(0000) 입력
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skb.smartrc:id/dialog_right_button
    Wait Until Element Is Visible    Xpath=//android.widget.TextView[@text="ZEM 종료 인증 설정 완료"]
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.widget.TextView[@text="확인"]
    Sleep    1
    Press Keycode    4    #Back 키 입력
    Sleep    1
    Press Keycode    4
    Sleep    1
    Press Keycode    4
    Sleep    1
    Wait until Element Is Visible    Xpath=//android.widget.TextView[@text="ZEM 종료"]    #ZEM 종료 팝업 노출확인
    성인인증번호(0000) 입력
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skb.smartrc:id/bt_right
    Sleep    1
    Wait until Element Is Visible    Xpath=//android.widget.TextView[@content-desc="탐색"]
    Sleep    1


    탐색 > ZEM 진입    #ZEM 종료 인증 설정 OFF
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skb.smartrc:id/rl_header_profile_info    #프로필 선택
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.widget.ImageView[@content-desc="설정"]
    Sleep    1
    성인인증번호(0000) 입력
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skb.smartrc:id/bt_right
    Sleep    1
    FOR  ${i}  IN RANGE    0    10    #My oksusu 소장 VOD 이용하기 노출시점까지 스크롤
        Swipe By Percent    50    70    50    30
        ${pass}    Run Keyword And Return Status    Wait until Element Is Visible    Xpath=//android.widget.TextView[@text="My oksusu 소장 VOD 이용하기"]
        Exit For Loop If    ${pass}
    END
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.widget.ScrollView/android.view.View[3]
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skb.smartrc:id/dialog_input
    Sleep    1
    성인인증번호(0000) 입력
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skb.smartrc:id/dialog_right_button
    Wait Until Element Is Visible    Xpath=//android.widget.TextView[@text="ZEM 종료 인증 설정 해지"]
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.widget.TextView[@text="확인"]
    Sleep    1
    Press Keycode    4
    Sleep    1
    Press Keycode    4
    Sleep    1
    Press Keycode    4
    Sleep    1
    Wait until Element Is Visible    Xpath=//android.widget.TextView[@content-desc="탐색"]

56781 홈 메인 타이틀 기능 확인 (알림, 리모콘)
    #1. 앱 실행 > 상단 알림 버튼 선택    /    1. '알림 목록' 타이틀 노출 확인
    #2. 상단 리모컨 버튼 선택    /    2. 'AI 스마트 리모컨', '코치마크' 노출 확인

    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skb.smartrc:id/iv_notify    #알림 버튼
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Wait Until Element Is Visible    Xpath=//android.widget.TextView[@text="알림 목록"]
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.widget.ImageButton[@content-desc="이전"]
    Sleep    1

    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skb.smartrc:id/iv_remocon_or_schedule    #리모컨 버튼
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Wait Until Element Is Visible    Xpath=//android.widget.TextView[@text="AI 스마트 리모컨"]
    Wait Until Keyword Succeeds    1 min    3 sec    Wait Until Element Is Visible    Xpath=//android.widget.ImageView[@content-desc="정보"]    #코치마크

56598 VOD 검색 결과 내 연관 추천 정보 제공 - B tv에서 보유한 콘텐츠
    #0. 검증 콘텐츠 <타짜 전설의 땁>
    #1. 앱 실행 > "탐색" > "검색" > 검색어 입력    /    1. '함께 찾은 VOD' 노출 시 pass

    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.view.ViewGroup[@content-desc="탐색버튼"]
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skb.smartrc:id/et_search_bar
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Input Text    com.skb.smartrc:id/top_search_bar    전설의 땁
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.widget.TextView[@text = '전설의 땁']
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Wait Until Element Is Visible    Xpath=//android.widget.TextView[@text = '함께 찾은 VOD']
    Element Text Should Be    Xpath=//android.widget.TextView[@text = '함께 찾은 VOD']    함께 찾은 VOD

56763 월정액 카드_상품탐색 카드 전체 상품 보기 이동
    #1. 앱 실행 >  "홈" > 퀵메뉴 내 "월정액" 진입
    #2. [전체 상품 보기] 버튼 선택    /    2. '전체 상품 보기' 타이틀, 월정액 블록 노출 확인
    #3. 상단 이전(<) 버튼 선택    /    3. '월정액' 타이틀 노출 확인 시 pass 

    FOR  ${i}  IN RANGE    0    10    #월정액 퀵메뉴 노출시점까지 스크롤
        Swipe By Percent    50    70    50    30
        ${pass}    Run Keyword And Return Status    Wait until Element Is Visible    Xpath=(//android.widget.ImageView[@resource-id="com.skb.smartrc:id/iv_icon"])[2]
        Exit For Loop If    ${pass}
    END
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=(//android.widget.ImageView[@resource-id="com.skb.smartrc:id/iv_icon"])[2]    #월정액 진입
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.widget.TextView[@text="전체 상품 보기"]
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Wait Until Element Is Visible    com.skb.smartrc:id/title    #'전체 상품 보기' 타이틀 노출 확인
    Wait Until Keyword Succeeds    1 min    3 sec    Wait Until Element Is Visible    Xpath=(//android.view.ViewGroup[@resource-id="com.skb.smartrc:id/cl_root"])[1]    #월정액 블록 노출 확인
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.widget.ImageButton[@content-desc="이전"]
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Wait Until Element Is Visible    Xpath=//android.widget.TextView[@text="월정액"]

56759 카테고리 > 공개예정 화면 확인
    #1. 앱 실행 > "탐색" > "공개예정" 진입 후 화면 확인    /    1. player, title, info 영역 노출 확인
    #2. 상단 이전(<) 버튼 선택    /    2. 탐색 메뉴 노출 확인 시 pass

    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.view.ViewGroup[@content-desc="탐색버튼"]
    Sleep    1
    FOR  ${i}  IN RANGE    0    10    #공개예정 메뉴 노출시점까지 스크롤
        Swipe By Percent    50    70    50    30
        ${pass}    Run Keyword And Return Status    Wait until Element Is Visible    Xpath=//android.view.ViewGroup[@content-desc="공개예정버튼"]
        Exit For Loop If    ${pass}
    END
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.view.ViewGroup[@content-desc="공개예정버튼"]
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Wait Until Element Is Visible    Xpath=//android.widget.FrameLayout[@resource-id="com.skb.smartrc:id/player_container"]
    Wait Until Keyword Succeeds    1 min    3 sec    Wait Until Element Is Visible    Xpath=//android.widget.LinearLayout[@resource-id="com.skb.smartrc:id/title_container"]
    Wait Until Keyword Succeeds    1 min    3 sec    Wait Until Element Is Visible    Xpath=//android.widget.LinearLayout[@resource-id="com.skb.smartrc:id/info_container"]

    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.widget.ImageButton[@content-desc="이전"]
    Sleep    1
    Wait Until Element Is Visible    Xpath=//android.widget.TextView[@content-desc="탐색"]

56739 시놉시스 > 액션 버튼 영역
    #1. 앱 실행 > "탐색" > "검색" > 검색어 입력 > 콘텐츠 진입 > 액션 버튼 영역 확인    /    1. 찜하기, 평가하기, 댓글남기기, Btv로 보기, 공유하기 버튼 노출 시 pass
    
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.view.ViewGroup[@content-desc="탐색버튼"]
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skb.smartrc:id/et_search_bar
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Input Text    com.skb.smartrc:id/top_search_bar    눈물의 여왕
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.widget.TextView[@text = '눈물의 여왕']
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.view.ViewGroup[@content-desc="눈물의 여왕"]
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Wait Until Element Is Visible    com.skb.smartrc:id/btn_favorite  
    Wait Until Keyword Succeeds    1 min    3 sec    Wait Until Element Is Visible    com.skb.smartrc:id/btn_rating    
    Wait Until Keyword Succeeds    1 min    3 sec    Wait Until Element Is Visible    com.skb.smartrc:id/btn_comment
    Wait Until Keyword Succeeds    1 min    3 sec    Wait Until Element Is Visible    com.skb.smartrc:id/btn_watch_in_btv
    Wait Until Keyword Succeeds    1 min    3 sec    Wait Until Element Is Visible    com.skb.smartrc:id/btn_recommend

56770 App 종료 확인
    #1. 앱 실행 > 이전 키 1회 입력    /    1. '앱 종료 안내' 토스트 팝업 로그(toast) 출력 및 'B 로고' 노출 확인
    #2. 이전 키 2회 입력    /    2. '앱 종료 안내' 토스트 팝업 로그(toast) 출력 및 'B 로고' 미 노출(앱 종료) 확인 시 pass
       
    Wait Until Element Is Visible    Xpath=//android.widget.ImageView[@content-desc="B 로고"]
    Run Process    adb logcat -c    shell=True
    Run Keyword And Ignore Error    Remove File    D://RFA/log.txt
    Press Keycode    4    #이전 키
    ${log}    Run Process    adb logcat -d 3 >> D://RFA/log.txt    shell=True
    ${String}    Get File    D://RFA/log.txt    encoding=ISO-8859-1
    Should Contain    ${String}    Toast
    Sleep    2
    Page Should Contain Element    Xpath=//android.widget.ImageView[@content-desc="B 로고"]

    Run Process    adb logcat -c    shell=True
    Run Keyword And Ignore Error    Remove File    D://RFA/log.txt
    Press Keycode    4    #이전 키
    Press Keycode    4    #이전 키
    ${log}    Run Process    adb logcat -d 3 >> D://RFA/log.txt    shell=True
    ${String}    Get File    D://RFA/log.txt    encoding=ISO-8859-1
    Should Contain    ${String}    Toast
    Sleep    2
    Page Should Not Contain Element    Xpath=//android.widget.ImageView[@content-desc="B 로고"]    

56674 앱 구동 후 공개예정/VOD 콘텐츠 자동재생 시 음소거로 재생 확인
    #0. CJ ENM 가입 / 검증 콘텐츠 <뿅뿅 지구오락실>
    #1. 앱 실행 > "탐색" > "공개예정" 진입    /    1. 음소거상태 로그(isMuted = true) 출력 확인
    #2. "탐색" > 임의의 VOD 검색 후 진입    /    2. 음소거상태 로그(isMuted = true) 출력 시 pass

    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.view.ViewGroup[@content-desc="탐색버튼"]
    Sleep    1
    Swipe By Percent    50    70    50    30
    Run Process    adb logcat -c    shell=True
    Run Keyword And Ignore Error    Remove File    D://RFA/log.txt
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.view.ViewGroup[@content-desc="공개예정버튼"]
    Sleep    3
    ${log}    Run Process    adb logcat -d 5 >> D://RFA/log.txt    shell=True
    ${String}    Get File    D://RFA/log.txt    encoding=ISO-8859-1
    Should Contain    ${String}    isMuted = true
    
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.view.ViewGroup[@content-desc="탐색버튼"]
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skb.smartrc:id/et_search_bar
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Input Text    com.skb.smartrc:id/top_search_bar    뿅뿅 지구오락실
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.widget.TextView[@text = '뿅뿅 지구오락실']
    Sleep    2
    Run Process    adb logcat -c    shell=True
    Run Keyword And Ignore Error    Remove File    D://RFA/log.txt
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.view.ViewGroup[@content-desc="뿅뿅 지구오락실"]
    Sleep    3
    ${log}    Run Process    adb logcat -d 5 >> D://RFA/log.txt    shell=True
    ${String}    Get File    D://RFA/log.txt    encoding=ISO-8859-1
    Should Contain    ${String}    isMuted = true

56663 Navigation Back_GNB
    #1. 앱 실행 > 홈 이전 키 1회 / 탐색, AI PICK, 무료, 정주행TV 이전 키 2회 (홈화면에서 토스트 팝업 노출)
    #2.'앱 종료 안내' 토스트 팝업 로그(toast) 출력 및 각 페이지 메뉴 노출 확인

    Wait Until Element Is Visible    Xpath=//android.view.ViewGroup[@content-desc="홈버튼"]
    Run Process    adb logcat -c    shell=True
    Run Keyword And Ignore Error    Remove File    D://RFA/log.txt
    Press Keycode    4    #이전 키
    Sleep    1
    ${log}    Run Process    adb logcat -d 5 >> D://RFA/log.txt    shell=True
    ${String}    Get File    D://RFA/log.txt    encoding=ISO-8859-1
    Should Contain    ${String}    Toast
    Sleep    1
    Page Should Contain Element    Xpath=//android.view.ViewGroup[@content-desc="홈버튼"]
    
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.view.ViewGroup[@content-desc="탐색버튼"]
    Sleep    1
    Wait Until Element Is Visible    Xpath=//android.view.ViewGroup[@content-desc="탐색버튼"]
    Run Process    adb logcat -c    shell=True
    Run Keyword And Ignore Error    Remove File    D://RFA/log.txt
    Press Keycode    4    #이전 키
    Sleep    1
    Press Keycode    4    #이전 키
    Sleep    1    
    ${log}    Run Process    adb logcat -d 5 >> D://RFA/log.txt    shell=True
    ${String}    Get File    D://RFA/log.txt    encoding=ISO-8859-1
    Should Contain    ${String}    Toast
    Sleep    1
    Page Should Contain Element    Xpath=//android.view.ViewGroup[@content-desc="홈버튼"]

    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.view.ViewGroup[@content-desc="AI PICK버튼"]
    Sleep    1
    Wait Until Element Is Visible    Xpath=//android.view.ViewGroup[@content-desc="AI PICK버튼"]
    Run Process    adb logcat -c    shell=True
    Run Keyword And Ignore Error    Remove File    D://RFA/log.txt
    Press Keycode    4    #이전 키
    Sleep    1
    Press Keycode    4    #이전 키
    Sleep    1
    ${log}    Run Process    adb logcat -d 5 >> D://RFA/log.txt    shell=True
    ${String}    Get File    D://RFA/log.txt    encoding=ISO-8859-1
    Should Contain    ${String}    Toast
    Sleep    1
    Page Should Contain Element    Xpath=//android.view.ViewGroup[@content-desc="AI PICK버튼"]

    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.view.ViewGroup[@content-desc="무료버튼"]
    Sleep    1
    Wait Until Element Is Visible    Xpath=//android.view.ViewGroup[@content-desc="무료버튼"]
    Run Process    adb logcat -c    shell=True
    Run Keyword And Ignore Error    Remove File    D://RFA/log.txt
    Press Keycode    4    #이전 키
    Sleep    1
    Press Keycode    4    #이전 키
    Sleep    1
    ${log}    Run Process    adb logcat -d 5 >> D://RFA/log.txt    shell=True
    ${String}    Get File    D://RFA/log.txt    encoding=ISO-8859-1
    Should Contain    ${String}    Toast
    Sleep    1
    Page Should Contain Element    Xpath=//android.view.ViewGroup[@content-desc="무료버튼"]

    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.view.ViewGroup[@content-desc="정주행TV버튼"]
    Sleep    1
    Wait Until Element Is Visible    Xpath=//android.view.ViewGroup[@content-desc="정주행TV버튼"]
    Run Process    adb logcat -c    shell=True
    Run Keyword And Ignore Error    Remove File    D://RFA/log.txt
    Press Keycode    4    #이전 키
    Sleep    1
    Press Keycode    4    #이전 키
    Sleep    1
    ${log}    Run Process    adb logcat -d 5 >> D://RFA/log.txt    shell=True
    ${String}    Get File    D://RFA/log.txt    encoding=ISO-8859-1
    Should Contain    ${String}    Toast
    Sleep    1
    Page Should Contain Element    Xpath=//android.view.ViewGroup[@content-desc="정주행TV버튼"]

56727 시놉시스 > 패키지 시놉시스 > 구조
    #1. 앱 실행 > "탐색" > "영화/시리즈" > "할인&패키지" 진입
    #2. 미구매 패키지 <웡카 자막+더빙 소장 패키지> 진입    /    2. 패키지 시놉시스 구조(이미지, 구매버튼, 구성콘텐츠, 콘텐츠 시놉시스) 노출 확인 시 pass

    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.view.ViewGroup[@content-desc="탐색버튼"]
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.view.ViewGroup[@content-desc="영화/시리즈버튼"]
    Sleep    1
    FOR  ${i}  IN RANGE    0    10    #할인&패키지 노출시점까지 스크롤
        Swipe By Percent    50    70    50    30
        ${pass}    Run Keyword And Return Status    Wait until Element Is Visible    Xpath=//android.view.ViewGroup[@content-desc="할인 & 패키지"]
        Exit For Loop If    ${pass}
    END
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.view.ViewGroup[@content-desc="할인 & 패키지"]
    Sleep    1

    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.widget.ImageView[@content-desc="웡카 자막+더빙 소장 패키지"]
    Wait Until Keyword Succeeds    1 min    3 sec    Wait Until Element Is Visible    com.skb.smartrc:id/iv_main    #이미지 노출 확인
    Wait Until Keyword Succeeds    1 min    3 sec    Wait Until Element Is Visible    com.skb.smartrc:id/btn_purchase    #구매 버튼 노출 확인
    Swipe By Percent    50    70    50    30
    Wait Until Keyword Succeeds    1 min    3 sec    Wait Until Element Is Visible    com.skb.smartrc:id/tv_composition_content    #'구성콘텐츠' 타이틀 노출 확인
    Wait Until Keyword Succeeds    1 min    3 sec    Wait Until Element Is Visible    com.skb.smartrc:id/recycler_view    #구성콘텐츠 블록 노출 확인
    Wait Until Keyword Succeeds    1 min    3 sec    Wait Until Element Is Visible    com.skb.smartrc:id/synopsis_header    #시놉시스 노출 확인

85638 홈 footer > 개인정보 이용내역 조회 메뉴 추가
    #1. 앱 실행 > 최하단 스크롤하여 footer 영역 확인    /    1. 개인정보 처리방침, 개인정보 이용내역, 청소년 보호정책 순 노출 시 pass
    
    FOR  ${i}  IN RANGE    0    10    #최하단으로 스크롤
        Swipe By Percent    50    85    50    15
        ${pass}    Run Keyword And Return Status    Wait until Element Is Visible    com.skb.smartrc:id/tv_skbroadband
        Exit For Loop If    ${pass}
    END
    Element Should Be Visible    Xpath=//android.widget.TextView[@text="개인정보 처리방침" and @index="0"]
    Element Should Be Visible    Xpath=//android.widget.TextView[@text="개인정보 이용내역" and @index="2"]
    Element Should Be Visible    Xpath=//android.widget.TextView[@text="이용약관 및 청소년 보호정책" and @index="4"]

85639 홈 footer > 개인정보 이용내역 선택
    #1. 앱 실행 > 최하단 스크롤 > 개인정보 이용내역 선택    /    1. 모바일 B tv 개인정보 이용내역 안내 화면 노출 시 pass
    
    FOR  ${i}  IN RANGE    0    10    #최하단으로 스크롤
        Swipe By Percent    50    85    50    15
        ${pass}    Run Keyword And Return Status    Wait until Element Is Visible    Xpath=//android.widget.TextView[@text="개인정보 이용내역"]
        Exit For Loop If    ${pass}
    END
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.widget.TextView[@text="개인정보 이용내역"]
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Wait until Element Is Visible    Xpath=//android.widget.TextView[@text="모바일 B tv 개인정보 이용내역 안내"]

85684 탐색 > ZEM 이동 및 모비 복귀시 GNB가 늦게 사라지는 현상 - 모바일 B tv 홈
    #1. 앱 실행 > "탐색" > ZEM 진입    /    1. 하단 GNB 미 노출 시 pass

    탐색 > ZEM 진입
    Sleep    2
    Page Should Not Contain Element    com.skb.smartrc:id/bottom_container

85685 탐색 > ZEM 이동 및 모비 복귀시 GNB가 늦게 사라지는 현상 - ZEM
    #1. 앱 실행 > "탐색" > ZEM 진입 > 나가기    /    1. 상단 ZEM GNB 미 노출 시 pass

    탐색 > ZEM 진입
    Sleep    2
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.widget.ImageView[@content-desc="젬종료"]
    Sleep    1
    Page Should Not Contain Element    com.skb.smartrc:id/gnb_recycler_view

85727 홈 footer > '사업자 정보 확인' 터치 영역 수정
    #1. 앱 실행 > 최하단 스크롤 > 'SK Broadband' 선택    /    1. 사업자 정보 노출 시 pass
    
    FOR  ${i}  IN RANGE    0    10    #최하단으로 스크롤
        Swipe By Percent    50    85    50    15
        ${pass}    Run Keyword And Return Status    Wait until Element Is Visible    com.skb.smartrc:id/tv_skbroadband
        Exit For Loop If    ${pass}
    END
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skb.smartrc:id/tv_skbroadband
    sleep    1
    FOR  ${i}  IN RANGE    0    10    #최하단으로 스크롤
        Swipe By Percent    50    85    50    15
        ${pass}    Run Keyword And Return Status    Wait until Element Is Visible    com.skb.smartrc:id/tv_skb_info
        Exit For Loop If    ${pass}
    END
    Wait Until Keyword Succeeds    1 min    3 sec    Wait until Element Is Visible    com.skb.smartrc:id/tv_skb_name

85728 Free 채널 재생 중 알림 목록 진입 시 동작
    #1. 앱 실행 > "무료" > Free 채널 재생 상태로 상단 알림 버튼 선택
    #2. Back 후 채널 일시정지 확인    /    2. 재생 로그(onProgress()) 출력되지 않을 시 pass

    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.view.ViewGroup[@content-desc="정주행TV버튼"]
    Sleep    2
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skb.smartrc:id/iv_notify
    Sleep    2
    Run Process    adb logcat -c    shell=True
    Run Keyword And Ignore Error    Remove File    D://RFA/log.txt
    
    Press Keycode    4
    Sleep    3
    ${log}    Run Process    adb logcat -d 5 >> D://RFA/log.txt    shell=True
    ${String}    Get File    D://RFA/log.txt    encoding=ISO-8859-1
    Should Not Contain    ${String}    onProgress()

85741 모비소식 웹페이지 이동규격 inlink로 변경 - 설정
    #1. 앱 실행 > "MY" > "설정" 최하단으로 스크롤
    #2. 모비소식 선택    /    2."모비소식" 타이틀 확인 시 pass 

    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skb.smartrc:id/iv_my    #"MY" 진입
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.widget.ImageView[@content-desc="설정"]
    Sleep    1
    FOR  ${i}  IN RANGE    0    10    #모비소식 노출시점까지 스크롤
        Swipe By Percent    50    70    50    30
        ${pass}    Run Keyword And Return Status    Wait until Element Is Visible    Xpath=//android.widget.TextView[@text="모비 소식"]
        Exit For Loop If    ${pass}
    END
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.widget.TextView[@text="모비 소식"]
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Wait until Element Is Visible    Xpath=//android.widget.TextView[@text="모비 소식" and @resource-id="com.skb.smartrc:id/title"]

85848 전체 콘텐츠 찜 해제 후 버튼 확인
    #1. 앱 실행 > "MY" > 찜 목록 진입
    #2. 콘텐츠 찜 해제    /    2. 전체삭제 버튼 dimmed 처리(enabled 값 = "false") 확인 후 pass

    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skb.smartrc:id/iv_my    #"MY" 진입
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.widget.TextView[@text="찜 목록"]
    Sleep    1   
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skb.smartrc:id/iv_favorite_star    #찜 해제
    Sleep    1
    ${false_enabled}=    Get Element Attribute    com.skb.smartrc:id/tv_favorite_remove_all    enabled    #전체삭제 버튼 enabled 값 확인    
    Should Be Equal As Strings    ${false_enabled}    false
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.widget.ImageView[@content-desc="찜 등록"]    #찜 재등록

56896 지상파 콘텐츠 시놉시스 내 안내문구 수정
    #0. 지상파 월정액 미가입 상태 / 검증 콘텐츠 <나 혼자 산다>
    #1. 앱 실행 > "탐색" > 지상파 콘텐츠 검색 > 콘텐츠 진입하여 하단 스크롤    /    1. 안내문구 정상 노출 시 pass 

    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.view.ViewGroup[@content-desc="탐색버튼"]
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skb.smartrc:id/et_search_bar
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Input Text    com.skb.smartrc:id/top_search_bar    나 혼자 산다
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.widget.TextView[@text ='나 혼자 산다']
    Sleep    2
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=(//android.view.ViewGroup[@content-desc="나 혼자 산다"])[1]
    Sleep    1
    FOR  ${i}  IN RANGE    0    3   
        Swipe By Percent    50    70    50    30
    END
    Element Should Be Visible    Xpath=//android.widget.TextView[@resource-id="com.skb.smartrc:id/tv_message" and @text="지상파 콘텐츠의 경우 B tv에서만 시청 가능한 회차는 제공되지 않습니다.\n지상파 월정액에 가입하시면 모든 회차를 모바일에서 시청하실 수 있습니다.\n※ 일부 콘텐츠는 방송사, 콘텐츠 제공사 또는 저작권자의 요청에 의해 모바일 시청이\n제공되지 않을 수 있습니다."]

57083 댓글/리뷰 작성 기능 제공 - 댓글 작성 정책-1
    #1. 앱 실행 > "탐색" > 임의의 콘텐츠 검색 후 시놉시스 진입 > [댓글남기기] 버튼 선택    /    1. 입력필드에 '댓글을 남겨주세요.' 문구 노출 확인
    #2. 입력필드 선택    /    2. [등록] 버튼 노출 시 pass

    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.view.ViewGroup[@content-desc="탐색버튼"]
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skb.smartrc:id/et_search_bar
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Input Text    com.skb.smartrc:id/top_search_bar    압꾸정
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.widget.TextView[@text ="압꾸정"]
    Sleep    2
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.view.ViewGroup[@content-desc="압꾸정"]
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skb.smartrc:id/btn_comment    #댓글남기기 버튼 클릭
    Sleep    1
    Element Should Be Visible       Xpath=//android.widget.TextView[@text="댓글을 남겨주세요."]
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.widget.TextView[@text="댓글을 남겨주세요."]
    Sleep    1
    Element Should Be Visible       Xpath=//android.widget.Button[@text="등록"]

57287 댓글/리뷰 작성 기능 제공 - 댓글 수정/삭제 정책-1
    #1. 앱 실행 > "탐색" > 임의의 콘텐츠 검색 후 시놉시스 진입 > [댓글남기기] 버튼 선택
    #2. 댓글 등록 후 해당 댓글 더보기 버튼 선택    /    2. 수정하기, 삭제하기 버튼 노출 시 pass  

    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.view.ViewGroup[@content-desc="탐색버튼"]
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skb.smartrc:id/et_search_bar
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Input Text    com.skb.smartrc:id/top_search_bar    압꾸정
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.widget.TextView[@text ="압꾸정"]
    Sleep    2
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.view.ViewGroup[@content-desc="압꾸정"]
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skb.smartrc:id/btn_comment    #댓글남기기 버튼 클릭
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.widget.TextView[@text="댓글을 남겨주세요."]
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Input Text    com.skb.smartrc:id/et_input_comment    TEST 댓글입니다
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.widget.Button[@text="등록"]
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=(//android.view.ViewGroup[@resource-id="com.skb.smartrc:id/cl_item_body"])[3]/android.view.View[1]
    Sleep    1
    Element Should Be Visible       Xpath=//android.widget.TextView[@text="수정하기"]
    Element Should Be Visible       Xpath=//android.widget.TextView[@text="삭제하기"]

57286 댓글/리뷰 작성 기능 제공 - 댓글 수정/삭제 정책-2
    #1. 앱 실행 > "탐색" > 임의의 콘텐츠 검색 후 시놉시스 진입 > [댓글남기기] 버튼 선택
    #2. 댓글 등록 후 해당 댓글 더보기 버튼 > [수정하기] 버튼 선택
    #3. 댓글 수정(TEST 댓글! → TEST 댓글) 후 [등록] 버튼 선택    /    3. 수정한 댓글 노출 시 pass

    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.view.ViewGroup[@content-desc="탐색버튼"]
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skb.smartrc:id/et_search_bar
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Input Text    com.skb.smartrc:id/top_search_bar    압꾸정
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.widget.TextView[@text ="압꾸정"]
    Sleep    2
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.view.ViewGroup[@content-desc="압꾸정"]
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skb.smartrc:id/btn_comment    #댓글남기기 버튼 클릭
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.widget.TextView[@text="댓글을 남겨주세요."]
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Input Text    com.skb.smartrc:id/et_input_comment    TEST 댓글!
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.widget.Button[@text="등록"]
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=(//android.view.ViewGroup[@resource-id="com.skb.smartrc:id/cl_item_body"])[3]/android.view.View[1]
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.widget.TextView[@text="수정하기"]
    Sleep    1
    Press Keycode    67    #Delete로 느낌표'!' 삭제
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.widget.Button[@text="등록"]
    Sleep    1
    Element Should Be Visible    Xpath=//android.widget.TextView[@resource-id="com.skb.smartrc:id/tv_comment" and @text="TEST 댓글"]

57285 댓글/리뷰 작성 기능 제공 - 댓글 수정/삭제 정책-3
    #1. 앱 실행 > "탐색" > 임의의 콘텐츠 검색 후 시놉시스 진입 > [댓글남기기] 버튼 선택
    #2. 댓글 등록 후 해당 댓글 더보기 버튼 > [삭제하기] 버튼 선택    /    2. 댓글 삭제 팝업 노출 확인
    #3-1. [취소] 버튼    /    3-1. 팝업 종료 확인
    #3-2. [확인] 버튼    /    3-2. 팝업 종료 후 해당 댓글 삭제 확인  

    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.view.ViewGroup[@content-desc="탐색버튼"]
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skb.smartrc:id/et_search_bar
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Input Text    com.skb.smartrc:id/top_search_bar    압꾸정
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.widget.TextView[@text ="압꾸정"]
    Sleep    2
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.view.ViewGroup[@content-desc="압꾸정"]
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skb.smartrc:id/btn_comment    #댓글남기기 버튼 클릭
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.widget.TextView[@text="댓글을 남겨주세요."]
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Input Text    com.skb.smartrc:id/et_input_comment    TEST3
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.widget.Button[@text="등록"]
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=(//android.view.ViewGroup[@resource-id="com.skb.smartrc:id/cl_item_body"])[2]/android.view.View[1]
    Sleep    1

    #[취소] 버튼 선택
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.widget.TextView[@text="삭제하기"]
    Sleep    1
    Element Should Be Visible    Xpath=//android.widget.TextView[@text="댓글을 삭제하시겠어요?"]
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skb.smartrc:id/btn_left
    Sleep    1
    Page Should Not Contain Element    Xpath=//android.widget.TextView[@text="댓글을 삭제하시겠어요?"]    #팝업 종료 확인
    
    #[삭제] 버튼 선택
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.widget.TextView[@text="삭제하기"]
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skb.smartrc:id/btn_right
    Sleep    1
    Page Should Not Contain Element    Xpath=//android.widget.TextView[@resource-id="com.skb.smartrc:id/tv_comment" and @text="TEST3"]    #댓글 삭제 확인

57266 댓글/리뷰 작성 기능 제공 - 등록 정보/일반 댓글
    #1. 앱 실행 > "탐색" > 임의의 콘텐츠 검색 후 시놉시스 진입 > [댓글남기기] 버튼 선택
    #2. 댓글 등록 > 댓글 정보 확인    /    2. 프로필 아이콘, 닉네임, 등록일시, MY아이콘 노출 시 pass  

    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.view.ViewGroup[@content-desc="탐색버튼"]
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skb.smartrc:id/et_search_bar
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Input Text    com.skb.smartrc:id/top_search_bar    압꾸정
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.widget.TextView[@text ="압꾸정"]
    Sleep    2
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.view.ViewGroup[@content-desc="압꾸정"]
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skb.smartrc:id/btn_comment    #댓글남기기 버튼 클릭
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.widget.TextView[@text="댓글을 남겨주세요."]
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Input Text    com.skb.smartrc:id/et_input_comment    댓글정보
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.widget.Button[@text="등록"]
    Sleep    2
    Element Should Be Visible    Xpath=//android.widget.ImageView[@resource-id="com.skb.smartrc:id/iv_profile_icon"]    #프로필 아이콘 노출 확인
    Element Should Be Visible    Xpath=//android.widget.TextView[@resource-id="com.skb.smartrc:id/tv_profile_name"]    #닉네임 노출 확인
    Element Should Be Visible    Xpath=//android.widget.TextView[@resource-id="com.skb.smartrc:id/tv_comment_date"]    #등록 일시 노출 확인
    Element Should Be Visible    com.skb.smartrc:id/v_comment_my_icon    #MY 아이콘 노출 확인

57258 댓글/리뷰 작성 기능 제공 - 등록 내용/일반 댓글-5
    #1. 앱 실행 > "탐색" > 임의의 콘텐츠 검색 후 시놉시스 진입 > [댓글남기기] 버튼 선택
    #2. 스포일러 버튼 체크하여 댓글 등록    /    2. "스포일러가 포함되어 있어요. 보기" 문구 노출 확인
    #3. [보기] 버튼 선택    /    3. 안내문구 사라지며 실제 등록된 내용 노출 시 pass

    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.view.ViewGroup[@content-desc="탐색버튼"]
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skb.smartrc:id/et_search_bar
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Input Text    com.skb.smartrc:id/top_search_bar    압꾸정
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.widget.TextView[@text ="압꾸정"]
    Sleep    2
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.view.ViewGroup[@content-desc="압꾸정"]
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skb.smartrc:id/btn_comment    #댓글남기기 버튼 클릭
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.widget.TextView[@text="댓글을 남겨주세요."]
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Input Text    com.skb.smartrc:id/et_input_comment    스포댓글 Test
    Sleep    1
    Element Should Be Visible    Xpath=//android.widget.TextView[@text="스포일러가 포함되어 있어요"]
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skb.smartrc:id/cb_selected    #스포일러 버튼 선택
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.widget.Button[@text="등록"]
    Sleep    2

    Element Should Be Visible    Xpath=//android.widget.TextView[@text="스포일러가 포함되어 있어요."]
    Element Should Be Visible    Xpath=//android.widget.TextView[@text="보기"]
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skb.smartrc:id/tv_spoiler_more    #[보기] 버튼 선택
    Element Should Be Visible    Xpath=//android.widget.TextView[@text="스포댓글 Test"]    #실제 등록 내용 노출 확인

57242 댓글/리뷰 작성 기능 제공 - 신고-2
    #1. 앱 실행 > "탐색" > 임의의 콘텐츠 검색 후 시놉시스 진입 > [댓글남기기] 버튼 선택
    #2. 임의의 댓글 [더보기] 버튼 > [신고하기] 버튼 선택    /    2. 신고하기 팝업 노출 확인
    #3. 상단 닫기(X) 버튼 선택    /    3. 신고하기 팝업 미 노출 시 pass

    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.view.ViewGroup[@content-desc="탐색버튼"]
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skb.smartrc:id/et_search_bar
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Input Text    com.skb.smartrc:id/top_search_bar    압꾸정
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.widget.TextView[@text ="압꾸정"]
    Sleep    2
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.view.ViewGroup[@content-desc="압꾸정"]
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skb.smartrc:id/btn_comment    #댓글남기기 버튼 클릭
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=(//android.view.ViewGroup[@resource-id="com.skb.smartrc:id/cl_item_body"])[2]/android.view.View[1]
    Sleep    2
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.widget.TextView[@text="신고하기"]
    Sleep    1

    #신고하기 팝업 확인
    Element Should Be Visible    Xpath=//android.widget.TextView[@text="신고 사유를 선택해 주세요."]
    Element Should Be Visible    Xpath=//android.widget.TextView[@resource-id="com.skb.smartrc:id/tv_report" and @text="타인에 대한 비방 및 욕설 "]
    Element Should Be Visible    Xpath=//android.widget.TextView[@resource-id="com.skb.smartrc:id/tv_report" and @text="음란성 또는 청소년에게 부적합한 내용"]
    Element Should Be Visible    Xpath=//android.widget.TextView[@resource-id="com.skb.smartrc:id/tv_report" and @text="상업적 광고/부적절한 홍보 게시물"]
    Element Should Be Visible    Xpath=//android.widget.TextView[@resource-id="com.skb.smartrc:id/tv_report" and @text="개인정보 유출/사생활 침해"]
    Element Should Be Visible    Xpath=//android.widget.TextView[@resource-id="com.skb.smartrc:id/tv_report" and @text="도배성 문구"]
    Element Should Be Visible    Xpath=//android.widget.TextView[@resource-id="com.skb.smartrc:id/tv_report" and @text="스포일러"]

    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.widget.ImageButton[@content-desc="닫기"]    #팝업 종료
    Sleep    1
    Page Should Not Contain Element    Xpath=//android.widget.TextView[@text="신고하기" and @resource-id="com.skb.smartrc:id/title"]    #신고하기 팝업 종료 확인

57230 MY 프론트 정책 - 타임스탬프 기능 등록된 댓글&답글
    #1. 앱 실행 > "탐색" > 임의의 콘텐츠 검색 후 시놉시스 진입 > [댓글남기기] 버튼 선택
    #2. 상단 댓글에 타임스탬프 기능 등록된 답글남기기    /    2. 등록된 답글 동일 확인 시 pass

    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.view.ViewGroup[@content-desc="탐색버튼"]
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skb.smartrc:id/et_search_bar
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Input Text    com.skb.smartrc:id/top_search_bar    압꾸정
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.widget.TextView[@text ="압꾸정"]
    Sleep    2
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.view.ViewGroup[@content-desc="압꾸정"]
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skb.smartrc:id/btn_comment    #댓글남기기 버튼 클릭
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=(//android.view.ViewGroup[@resource-id="com.skb.smartrc:id/cl_item_body"])[2]
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.widget.TextView[@text="답글을 남겨주세요."]
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Input Text    com.skb.smartrc:id/et_input_comment    11:11
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.widget.Button[@text="등록"]
    Sleep    2

    Element Should Be Visible    Xpath=//android.widget.TextView[@resource-id="com.skb.smartrc:id/tv_comment" and @text="11:11"]    #등록된 답글 동일 확인

57223 MY 프론트 정책 - 답글 있는 댓글 삭제
    #1. 앱 실행 > "탐색" > 임의의 콘텐츠 검색 후 시놉시스 진입 > [댓글남기기] 버튼 선택
    #2. 답글이 있는 댓글 선택 > [더보기] 버튼 > [삭제하기] 버튼 선택    /    2. 댓글 삭제 팝업 노출 확인
    #3-1. [취소] 버튼    /    3-1. 팝업 종료 확인
    #3-2. [확인] 버튼    /    3-2. 팝업 종료 후 해당 댓글 삭제 확인

    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.view.ViewGroup[@content-desc="탐색버튼"]
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skb.smartrc:id/et_search_bar
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Input Text    com.skb.smartrc:id/top_search_bar    압꾸정
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.widget.TextView[@text ="압꾸정"]
    Sleep    2
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.view.ViewGroup[@content-desc="압꾸정"]
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skb.smartrc:id/btn_comment    #댓글남기기 버튼 클릭
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=(//android.widget.TextView[@resource-id="com.skb.smartrc:id/tv_reply_count"])[2]    #답글 있는 댓글 선택
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=(//android.view.ViewGroup[@resource-id="com.skb.smartrc:id/cl_item_body"])[3]/android.view.View[2]    #더보기 선택
    Sleep    1
    
    #[취소] 버튼 선택
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.widget.TextView[@text="삭제하기"]
    Sleep    1
    Element Should Be Visible    Xpath=//android.widget.TextView[@text="댓글을 삭제하시겠어요?"]
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skb.smartrc:id/btn_left
    Sleep    1
    Page Should Not Contain Element    Xpath=//android.widget.TextView[@text="댓글을 삭제하시겠어요?"]    #팝업 종료 확인
    
    #[삭제] 버튼 선택
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.widget.TextView[@text="확인"]
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skb.smartrc:id/btn_right
    Sleep    1
    Page Should Not Contain Element    Xpath=//android.widget.TextView[@resource-id="com.skb.smartrc:id/tv_comment" and @text="TEST3"]    #댓글 삭제 확인

57177 MY - 내 댓글 메뉴
    #1. 

    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skb.smartrc:id/iv_my    #"MY" 진입
    Sleep    1
    FOR  ${i}  IN RANGE    0    10
        Swipe By Percent    50    70    50    30
        ${pass}    Run Keyword And Return Status    Wait until Element Is Visible    com.skb.smartrc:id/tv_menu_name
        Exit For Loop If    ${pass}
    END
    