*** Settings ***
Library    AppiumLibrary
Library    Process
Library    OperatingSystem

Resource    mBtv.resource
Suite Setup    앱 실행
Test Setup    앱 종료 후 재진입


*** Test Cases ***

검색 및 검색결과 동작 확인
    #1. 앱 실행 > "검색" > 검색어 입력    /    1. 검색결과 문구 및 VOD, 에피소드, 클립, 코너, 실시간 TV, 인물 블록 노출 확인
    #2. Top 버튼 선택    /    2. Top 버튼 페이지 내 미 존재 시 pass
    
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.widget.RelativeLayout[@content-desc="탐색버튼"]
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skb.smartrc:id/et_search_bar
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Input Text    com.skb.smartrc:id/top_search_bar    바람
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.widget.TextView[@text = '바람']
    Sleep    2

    Wait Until Keyword Succeeds    1 min    3 sec    Wait Until Element Is Visible    com.skb.smartrc:id/result_title
    Element Text Should Be    com.skb.smartrc:id/result_title    바람에 대한 검색 결과입니다.

    Wait Until Element Is Visible    Xpath=//android.widget.TextView[@text = 'VOD']
    Wait Until Element Is Visible    Xpath=//android.widget.TextView[@text = '에피소드']
    Wait Until Element Is Visible    Xpath=//android.widget.TextView[@text = '클립']

    FOR  ${i}  IN RANGE    0    10    #코너 블록 노출시점까지 스크롤
        Swipe By Percent    50    70    50    30
        ${pass}    Run Keyword And Return Status    Wait until Element Is Visible    Xpath=//android.widget.TextView[@text = '코너']
        Exit For Loop If    ${pass}
    END

    FOR  ${i}  IN RANGE    0    10    #실시간 TV 블록 노출시점까지 스크롤
        Swipe By Percent    50    70    50    30
        ${pass}    Run Keyword And Return Status    Wait until Element Is Visible    Xpath=//android.widget.TextView[@text = '실시간 TV']
        Exit For Loop If    ${pass}
    END

    FOR  ${i}  IN RANGE    0    10    #인물 블록 노출시점까지 스크롤
        Swipe By Percent    50    70    50    30
        ${pass}    Run Keyword And Return Status    Wait until Element Is Visible    Xpath=//android.widget.TextView[@text = '인물']
        Exit For Loop If    ${pass}
    END
 
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skb.smartrc:id/go_to_top    #최상단 이동 버튼
    Sleep    3        
    Page Should Not Contain Element    com.skb.smartrc:id/go_to_top

무료 VOD 재생 확인
    #0. 검증 콘텐츠 <미녀는 괴로워>
    #1. 앱 실행 > "탐색" > 무료 콘텐츠 검색 후 진입    /    1. 본편 재생 로그("event_type":"3") 출력 및 '무료 시청 가능' 문구 노출 시 pass

    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.widget.RelativeLayout[@content-desc="탐색버튼"]
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skb.smartrc:id/et_search_bar
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Input Text    com.skb.smartrc:id/top_search_bar    미녀는 괴로워
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.widget.TextView[@text = '미녀는 괴로워']
    Sleep    2
    Run Process    adb logcat -c    shell=True
    Run Keyword And Ignore Error    Remove File    D://RFA/log.txt

    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.view.ViewGroup[@content-desc="미녀는 괴로워"]
    Sleep    45
    ${log}    Run Process    adb logcat -d 50 >> D://RFA/log.txt    shell=True
    ${String}    Get File    D://RFA/log.txt    encoding=ISO-8859-1
    Should Contain    ${String}    "event_type":"3"
    Wait Until Element Is Visible    Xpath=//android.widget.TextView[@text = '무료 시청 가능']

가입된 월정액 VOD 재생 확인
    #0. CJ ENM 가입 / 검증 콘텐츠 <뿅뿅 지구오락실>
    #1. 앱 실행 > "탐색" > 가입된 월정액에 포함된 콘텐츠 검색 > 재생    /    1. ppm_ids 및 본편 재생 로그("event_type":"3") 출력 시 pass

    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.widget.RelativeLayout[@content-desc="탐색버튼"]
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
    Sleep    10
    ${log}    Run Process    adb logcat -d 15 >> D://RFA/log.txt    shell=True
    ${String}    Get File    D://RFA/log.txt    encoding=ISO-8859-1
    Should Contain    ${String}    "ppm_ids":"1649234"
    Should Contain    ${String}    "event_type":"3"

예고편, 미리보기 동작 확인
    #0. 검증 콘텐츠 <슈퍼 마리오 브라더스> 미구매 상태
    #1. 앱 실행 > "탐색" > 미구매 콘텐츠 검색 > 재생    /    1. 미리보기 로그(getPreviewInfo) 출력 확인

    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.widget.RelativeLayout[@content-desc="탐색버튼"]
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skb.smartrc:id/et_search_bar
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Input Text    com.skb.smartrc:id/top_search_bar    슈퍼 마리오 브라더스
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.widget.TextView[@text = '슈퍼 마리오 브라더스']
    Sleep    2
    Run Process    adb logcat -c    shell=True
    Run Keyword And Ignore Error    Remove File    D://RFA/log.txt

    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.view.ViewGroup[@content-desc="슈퍼 마리오 브라더스"]
    Sleep    5
    ${log}    Run Process    adb logcat -d 10 >> D://RFA/log.txt    shell=True
    ${String}    Get File    D://RFA/log.txt    encoding=ISO-8859-1
    Should Contain    ${String}    getPreviewInfo

ZEM키즈 진입 후 프리뷰 및 VOD 재생 확인
    #0. 검증 콘텐츠 <17회 뽀롱뽀롱 뽀로로 시즌7 / 바다로 간 루피>
    #1. 앱 실행 > "탐색" > ZEM 진입 > "검색" > 검색어 입력 > VOD 재생    /    1. VOD 광고 후 본편 재생 로그(click.vod.play) 출력 확인 

    탐색 > ZEM 진입
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skb.smartrc:id/iv_search    #검색버튼
    Sleep    1
    Wait Until Element Is Visible    com.skb.smartrc:id/top_search_bar
    Wait Until Keyword Succeeds    1 min    3 sec    Input Text    com.skb.smartrc:id/top_search_bar    바다로 간 루피
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skb.smartrc:id/top_search_icon
    Sleep    3
    Run Process    adb logcat -c    shell=True
    Run Keyword And Ignore Error    Remove File    D://RFA/log.txt
    
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.widget.TextView[@text = '17회 바다로 간 루피']
    Sleep    45
    ${log}    Run Process    adb logcat -d 50 >> D://RFA/log.txt    shell=True
    ${String}    Get File    D://RFA/log.txt    encoding=ISO-8859-1
    Should Contain    ${String}    click.vod.play

패키지 게이트웨이 진입 확인
    #0. 검증 콘텐츠 : 미구매 패키지 <트랜스포머 전편 소장 패키지>, 구매 패키지 <엘리멘탈 자막+더빙 소장 패키지>
    #1. 앱 실행 > "탐색" > "영화/시리즈" > "할인&패키지" 진입
    #2. 미구매 패키지 <트랜스포머 전편 소장 패키지> 진입    /    2. 구매버튼 노출 확인
    #3. 뒤로가기
    #4. 구매 패키지 <엘리멘탈 자막+더빙 소장 패키지> 진입    /    4. 구매버튼 미 노출 시 pass

    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.widget.RelativeLayout[@content-desc="탐색버튼"]
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.view.ViewGroup[@content-desc="영화/시리즈버튼"]
    Sleep    1
    FOR  ${i}  IN RANGE    0    5    #할인&패키지 노출시점까지 스크롤
        Swipe By Percent    50    70    50    30
        ${pass}    Run Keyword And Return Status    Wait until Element Is Visible    Xpath=//android.view.ViewGroup[@content-desc="할인 & 패키지"]
        Exit For Loop If    ${pass}
    END
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.view.ViewGroup[@content-desc="할인 & 패키지"]
    Sleep    1

    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.widget.ImageView[@content-desc="트랜스포머 전편 소장 패키지"]
    Wait Until Keyword Succeeds    1 min    3 sec    Wait Until Element Is Visible    com.skb.smartrc:id/btn_purchase
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skb.smartrc:id/iv_back

    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.widget.ImageView[@content-desc="엘리멘탈 자막+더빙 소장 패키지"]
    Sleep    3
    Page Should Not Contain Element    com.skb.smartrc:id/btn_purchase