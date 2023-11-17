*** Settings ***
Library    AppiumLibrary
Library    Process
Library    OperatingSystem

Resource    mBtv.resource
Suite Setup    앱 실행
Test Setup    앱 종료 후 재진입


*** Test Cases ***

찜 목록 카드 확인
    #1. 앱 실행 > "MY" > 찜 목록 진입    /    1. '찜 목록은 60개까지 저장됩니다.' 문구 노출 확인
    #2. 임의의 포스터 선택하여 시놉시스 진입    /    2. VOD 타이틀 노출 확인 시 pass

    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.widget.RelativeLayout[@content-desc="MY버튼"]
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.widget.TextView[@text="찜 목록"]
    Sleep    1
    Element Text Should Be    com.skb.smartrc:id/tv_title_comment    찜 목록은 60개까지 저장됩니다.
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.widget.ImageView[@resource-id="com.skb.smartrc:id/iv_favorite_poster"]
    Sleep    1
    Wait Until Element Is Visible    com.skb.smartrc:id/tv_title

TV다시보기 콘텐츠 전체 가격 표기 삭제 확인
    #1. 앱 실행 > "탐색" > TV다시보기 진입
    #2. 아래로 스크롤 하면서 가격 미노출 확인    /    2. 스크롤 끝날 때까지 가격(0원)이 포함된 엘리먼트 노출되지 않을 시 pass

    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.widget.RelativeLayout[@content-desc="탐색버튼"]
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.view.ViewGroup[@content-desc="TV다시보기버튼"]
    Sleep    1
    FOR  ${i}  IN RANGE    0    10    #아래로 스크롤 하면서 가격이 노출되지 않는 지 확인
        Page Should Not Contain Element    Xpath=//android.widget.TextView[contains(@text, "0원")]
        Swipe By Percent    50    70    50    30
    END

카테고리_진입 정책 확인 (ZEM키즈)
    #1. 앱 실행 > "탐색" > ZEM 진입    /    1. ZEM키즈 홈 노출 확인 시 pass

    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.widget.RelativeLayout[@content-desc="탐색버튼"]
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.view.ViewGroup[@content-desc="ZEM버튼"]
    Sleep    1
    Wait Until Element Is Visible    Xpath=//android.widget.ImageView[@content-desc="홈"]
    
Navigation Back_예외케이스 확인 (인물정보)
    #1. 앱 실행 > "탐색" > '클래식' 시놉시스 진입 > '조승우' 인물정보 이동 > 연관 콘텐츠 내 '신성한, 이혼' 진입    
    #2. Back(<) 키 입력    /    2. 첫 진입 콘텐츠인 '클래식' 시놉시스로 이동 시 pass 

    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.widget.RelativeLayout[@content-desc="탐색버튼"]
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skb.smartrc:id/et_search_bar
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Input Text    com.skb.smartrc:id/top_search_bar    클래식
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.widget.TextView[@text = '클래식']
    Sleep    2

    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.view.ViewGroup[@content-desc="클래식"]
    Sleep    1
    Swipe By Percent    50    70    50    30
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.widget.TextView[@text = "조승우"]
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.view.ViewGroup[@content-desc="신성한, 이혼"]
    Sleep    1
    Wait Until Element Is Visible    Xpath=//android.widget.TextView[@text = "신성한, 이혼 1회"]    
    Press Keycode    4    #Back 키 입력
    Sleep    1
    Wait Until Element Is Visible    Xpath=//android.widget.TextView[@text = "클래식"]

카테고리 구성 확인
    #1. 앱 실행 > "홈" > 퀵메뉴 내 "B이용꿀팁" 진입    /    1. "B 이용 꿀팁" 타이틀 노출 확인
    #2. "탐색" > 카테고리 내 "공개예정" 진입    /    2. "공개예정" 타이틀 노출 확인
    #3. "탐색" > 카테고리 내 "이벤트" 진입    /    3. "이벤트" 타이틀 노출 확인 시 pass

    FOR  ${i}  IN RANGE    0    10    #B이용꿀팁 퀵메뉴 노출시점까지 스크롤
        Swipe By Percent    50    70    50    30
        ${pass}    Run Keyword And Return Status    Wait until Element Is Visible    Xpath=//android.widget.FrameLayout[@resource-id="com.skb.smartrc:id/card_view" and @index="4"]
        Exit For Loop If    ${pass}
    END
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.widget.FrameLayout[@resource-id="com.skb.smartrc:id/card_view" and @index="4"]
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Element Text Should Be    com.skb.smartrc:id/title    B 이용 꿀팁
    Press Keycode    4

    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.widget.RelativeLayout[@content-desc="탐색버튼"]
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.view.ViewGroup[@content-desc="공개예정버튼"]
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Wait Until Element Is Visible    Xpath=//android.widget.TextView[@text="공개예정"]
    Press Keycode    4
    Sleep    1

    FOR  ${i}  IN RANGE    0    10    #이벤트 메뉴 노출시점까지 스크롤
        Swipe By Percent    50    70    50    30
        ${pass}    Run Keyword And Return Status    Wait until Element Is Visible    Xpath=//android.view.ViewGroup[@content-desc="이벤트버튼"]
        Exit For Loop If    ${pass}
    END
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.view.ViewGroup[@content-desc="이벤트버튼"]
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Element Text Should Be    com.skb.smartrc:id/title    이벤트
    
월정액 화면 내 기간권 이용중 문구 노출 확인
    #0. CJ ENM 월정액 가입 상태
    #1. 앱 실행 >  "홈" > 퀵메뉴 내 "월정액" 진입
    #2. 가입된 월정액 선택(CJ ENM) > 안내문구 확인    /    2. '아래의 모든 콘텐츠를 마음껏 즐겨보세요!' 문구 확인 시 pass

    FOR  ${i}  IN RANGE    0    10    #월정액 퀵메뉴 노출시점까지 스크롤
        Swipe By Percent    50    70    50    30
        ${pass}    Run Keyword And Return Status    Wait until Element Is Visible    Xpath=//android.widget.FrameLayout[@resource-id="com.skb.smartrc:id/card_view" and @index="1"]
        Exit For Loop If    ${pass}
    END
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.widget.FrameLayout[@resource-id="com.skb.smartrc:id/card_view" and @index="1"]
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.widget.RelativeLayout[@content-desc="CJ ENM 월정액"]
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Wait Until Element Is Visible    Xpath=//android.widget.TextView[@text="아래의 모든 콘텐츠를 마음껏 즐겨보세요!"]

ZEM 검색어 입력 동작
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
    Wait Until Element Is Visible    Xpath=//android.widget.TextView[@text="VOD"]

ZEM 검색어 자동완성
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
    Wait Until Element Is Visible    Xpath=//android.widget.TextView[@text="뽀로로 뮤직박스"]
    Wait Until Element Is Visible    Xpath=//android.widget.TextView[@text="뽀로로 뮤직박스 바다동물 노래"]
    Wait Until Element Is Visible    Xpath=//android.widget.TextView[@text="뽀로로의 올바른 생활습관"]

    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skb.smartrc:id/top_search_remove
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Input Text    com.skb.smartrc:id/top_search_bar    타짜
    Sleep    1
    Page Should Not Contain Element    com.skb.smartrc:id/top_search_bar_auto_complete    #자동완성 영역 미노출 확인

키즈 전용 UI_gnb 상단 고정영역 기능 확인 (이용권,검색,나가기)
    #1. 앱 실행 > "탐색" > "잼키즈" > 상단 이용권 버튼 선택    /    1. 이용권 타이틀 노출 확인
    #2. 이전 키 > 상단 검색 버튼 선택    /    2. 검색바 노출 확인
    #3. 이전 키 > 상단 나가기 버튼 선택    /    3. 잼 진입 이전 탐색 화면 노출 확인 시 pass
    
    탐색 > ZEM 진입
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.widget.ImageView[@content-desc="이용권"]    #이용권 버튼
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
    Wait Until Element Is Visible    com.skb.smartrc:id/tv_location

ZEM 키즈 종료
    #1. 앱 실행 > "탐색" > "잼키즈" > 프로필 > 인증번호 입력 후 설정 진입
    #2. ZEM 종료 인증 설정 ON > Back 키 3회 입력 > ZEM 종료 팝업 인증    /    2. 탐색 화면 이동 확인
    #3. ZEM 재 진입 > 프로필 > 인증번호 입력 후 설정 진입
    #4. ZEM 종료 인증 설정 OFF > Back 키 3회 입력    /    4. 탐색 화면 이동 확인 시 pass   
      
    탐색 > ZEM 진입    #ZEM 종료 인증 설정 ON
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skb.smartrc:id/rl_header_profile_info    #프로필 선택
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.widget.ImageView[@content-desc="설정"]
    Sleep    1
    인증번호(1111) 입력
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skb.smartrc:id/bt_right
    Sleep    1
    FOR  ${i}  IN RANGE    0    10    #My oksusu 소장 VOD 이용하기 노출시점까지 스크롤
        Swipe By Percent    50    70    50    30
        ${pass}    Run Keyword And Return Status    Wait until Element Is Visible    Xpath=//android.widget.TextView[@text="My oksusu 소장 VOD 이용하기"]
        Exit For Loop If    ${pass}
    END
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skb.smartrc:id/settings_auth_pzemkids_end_auth_chk
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skb.smartrc:id/dialog_input
    Sleep    1
    인증번호(1111) 입력
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skb.smartrc:id/dialog_right_button
    Wait Until Element Is Visible    Xpath=//android.widget.TextView[@text="ZEM 종료 인증 설정 완료"]
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skb.smartrc:id/btn_right
    Sleep    1
    Press Keycode    4    #Back 키 입력
    Sleep    1
    Press Keycode    4
    Sleep    1
    Press Keycode    4
    Sleep    1
    Wait until Element Is Visible    Xpath=//android.widget.TextView[@text="ZEM 종료"]    #ZEM 종료 팝업 노출확인
    인증번호(1111) 입력
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
    인증번호(1111) 입력
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skb.smartrc:id/bt_right
    Sleep    1
    FOR  ${i}  IN RANGE    0    10    #My oksusu 소장 VOD 이용하기 노출시점까지 스크롤
        Swipe By Percent    50    70    50    30
        ${pass}    Run Keyword And Return Status    Wait until Element Is Visible    Xpath=//android.widget.TextView[@text="My oksusu 소장 VOD 이용하기"]
        Exit For Loop If    ${pass}
    END
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skb.smartrc:id/settings_auth_pzemkids_end_auth_chk
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skb.smartrc:id/dialog_input
    Sleep    1
    인증번호(1111) 입력
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skb.smartrc:id/dialog_right_button
    Wait Until Element Is Visible    Xpath=//android.widget.TextView[@text="ZEM 종료 인증 설정 해지"]
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skb.smartrc:id/btn_right
    Sleep    1
    Press Keycode    4
    Sleep    1
    Press Keycode    4
    Sleep    1
    Press Keycode    4
    Sleep    1
    Wait until Element Is Visible    Xpath=//android.widget.TextView[@content-desc="탐색"]