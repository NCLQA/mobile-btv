*** Settings ***
Library    AppiumLibrary
Library    Process
Library    OperatingSystem

Resource    mBtv.resource
Suite Setup    앱 실행
Test Setup    앱 종료 후 재진입


*** Test Cases ***

56525 검색 및 검색결과 동작 확인
    #1. 앱 실행 > "검색" > 검색어 입력    /    1. 검색결과 문구 및 VOD, 에피소드, 클립, 코너, 실시간 TV, 인물 블록 노출 확인
    #2. Top 버튼 선택    /    2. Top 버튼 페이지 내 미 존재 시 pass
    
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.view.ViewGroup[@content-desc="탐색버튼"]
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

56524 가입된 월정액 VOD 재생 확인
    #0. CJ ENM 가입 / 검증 콘텐츠 <뿅뿅 지구오락실>
    #1. 앱 실행 > "탐색" > 가입된 월정액에 포함된 콘텐츠 검색 > 재생    /    1. ppm_ids 및 본편 재생 로그("event_type":"3") 출력 시 pass

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
    Sleep    10
    ${log}    Run Process    adb logcat -d 15 >> D://RFA/log.txt    shell=True
    ${String}    Get File    D://RFA/log.txt    encoding=ISO-8859-1
    Should Contain    ${String}    "ppm_ids":"1649234"
    Should Contain    ${String}    "event_type":"3"

56534 예고편, 미리보기 동작 확인
    #0. 검증 콘텐츠 <슈퍼 마리오 브라더스> 미구매 상태
    #1. 앱 실행 > "탐색" > 미구매 콘텐츠 검색 > 재생    /    1. 미리보기 로그(getPreviewInfo) 출력 확인

    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.view.ViewGroup[@content-desc="탐색버튼"]
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skb.smartrc:id/et_search_bar
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Input Text    com.skb.smartrc:id/top_search_bar    쿵푸팬더 3
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.widget.TextView[@text = '쿵푸팬더 3']
    Sleep    2
    Run Process    adb logcat -c    shell=True
    Run Keyword And Ignore Error    Remove File    D://RFA/log.txt

    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.view.ViewGroup[@content-desc="쿵푸팬더 3"]
    Sleep    5
    ${log}    Run Process    adb logcat -d 10 >> D://RFA/log.txt    shell=True
    ${String}    Get File    D://RFA/log.txt    encoding=ISO-8859-1
    Should Contain    ${String}    getPreviewInfo

56528 ZEM키즈 진입 후 프리뷰 및 VOD 재생 확인
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
    Sleep    55
    ${log}    Run Process    adb logcat -d 60 >> D://RFA/log.txt    shell=True
    ${String}    Get File    D://RFA/log.txt    encoding=ISO-8859-1
    Should Contain    ${String}    click.vod.play

56533 패키지 게이트웨이 진입 확인
    #0. 검증 콘텐츠 : 미구매 패키지 <수퍼 소닉 3 자막+더빙 소장 패키지>, 구매 패키지 <엘리멘탈 자막+더빙 소장 패키지>
    #1. 앱 실행 > "탐색" > "영화/시리즈" > "할인&패키지" 진입
    #2. 미구매 패키지 <수퍼 소닉 3 자막+더빙 소장 패키지> 진입    /    2. 구매버튼 노출 확인
    #3. 뒤로가기
    #4. 구매 패키지 <엘리멘탈 자막+더빙 소장 패키지> 진입    /    4. 구매버튼 미 노출 시 pass
    ## 위 콘텐츠 편성에 따라 유동적으로 변동

    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.view.ViewGroup[@content-desc="탐색버튼"]
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

    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.widget.ImageView[@content-desc="수퍼 소닉 3 자막+더빙 소장 패키지 [HD]"]
    Wait Until Keyword Succeeds    1 min    3 sec    Wait Until Element Is Visible    com.skb.smartrc:id/btn_purchase
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skb.smartrc:id/iv_back

    FOR  ${i}  IN RANGE    0    10
        Swipe By Percent    50    80    60    30
        ${pass}    Run Keyword And Return Status    Wait until Element Is Visible    Xpath=//android.widget.ImageView[@content-desc="엘리멘탈 자막+더빙 소장 패키지 [HD]"]
        Exit For Loop If    ${pass}
    END

    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.widget.ImageView[@content-desc="엘리멘탈 자막+더빙 소장 패키지 [HD]"]
    Sleep    3
    Page Should Not Contain Element    com.skb.smartrc:id/btn_purchase

56527 MY 찜 (추가, 편집, 삭제)
    #1. 앱 실행 > "MY" > "찜 목록" > 전체삭제    /    1. "찜한 콘텐츠가 없습니다" 노출 확인
    #2. 찜 목록 > 찜된 임의의 콘텐츠 편집 > Back(<) 키 입력 > "MY"에서 "찜 목록" 재 진입    /    2. 임의의 찜한 콘텐츠 미노출 확인
    #3. 임의의 콘텐츠 선택 > 콘텐츠 찜하기 후 뒤로가기 > 찜 목록 진입    /    3. 찜목록에 찜하기 한 콘텐츠 확인

    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skb.smartrc:id/iv_my
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.widget.TextView[@text="찜 목록"]
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skb.smartrc:id/tv_favorite_remove_all
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skb.smartrc:id/btn_right
    Wait Until Keyword Succeeds    1 min    3 sec    Wait Until Element Is Visible    com.skb.smartrc:id/tv_my_favorite_no_contents

    앱 종료 후 재진입
    임의의 콘텐츠 목록까지 스크롤
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.view.View[@resource-id="com.skb.smartrc:id/iv_gradation"]
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skb.smartrc:id/favorite_image
    Press Keycode    4
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skb.smartrc:id/iv_my
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.widget.TextView[@text="찜 목록"]
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skb.smartrc:id/iv_favorite_star
    Press Keycode    4
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.widget.TextView[@text="찜 목록"]

    앱 종료 후 재진입
    임의의 콘텐츠 목록까지 스크롤
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.view.View[@resource-id="com.skb.smartrc:id/iv_gradation"]
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skb.smartrc:id/favorite_image
    Press Keycode    4
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skb.smartrc:id/iv_my
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.widget.TextView[@text="찜 목록"]

116635 AI Smart Controller - TV 컨트롤러 채널 이동
    #1. 앱 실행 > Top 메뉴 리모컨 선택 > 123버튼 선택
    #2. 임의의 채널 입력 후 "이동버튼" 선택 > 입력 된 채널 이동 확인
    
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skb.smartrc:id/iv_remocon_or_schedule    #리모컨 버튼
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Wait Until Element Is Visible    Xpath=//android.widget.TextView[@text="AI 스마트 리모컨"]
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skb.smartrc:id/btn_input_number
    채널번호(168) 입력
    Sleep    1

    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skb.smartrc:id/btn_input_edit
    Wait Until Keyword Succeeds    1 min    3 sec    Wait Until Element Is Visible    Xpath=//android.widget.TextView[@text= "168"]

116638 AI Smart Controller - TV 컨트롤러 음량 Up/Down
    #0. STB 음량 최대(32)로 설정 되있는 상태
    #1. 앱 실행 > Top 메뉴 리모컨 선택 > 음량 Down 버튼 5번 누름 > 음량조절바 27인지 확인
    #2. 음량 UP 버튼 5번 누름 > 음량조절바 32인지 확인

    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skb.smartrc:id/iv_remocon_or_schedule    #리모컨 버튼
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Wait Until Element Is Visible    Xpath=//android.widget.TextView[@text="AI 스마트 리모컨"]
    Sleep    1
    FOR    ${I}    IN RANGE    0    5
        Sleep    1
        Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skb.smartrc:id/btn_volume_down
    END
    Wait Until Keyword Succeeds    1 min    3 sec    Wait Until Element Is Visible    Xpath=//android.widget.SeekBar[@text= "27.0"]
    Sleep    1

    FOR    ${I}    IN RANGE    0    5
        Sleep    1
        Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skb.smartrc:id/btn_volume_up
    END
    Wait Until Keyword Succeeds    1 min    3 sec    Wait Until Element Is Visible    Xpath=//android.widget.SeekBar[@text= "32.0"]

130292 에이닷 연결/해제 동작 확인
    #0. 에이닷 지원 STB 연결, 프로필 에이닷 미연결 상태
    #1. MY > 닉네임 하단 에이닷 연결하기 선택 > 에이닷 연결 약관 모두 동의 선택 > 연결 완료 팝업 노출 > 확인 선택
    #2. 프로필 설정 진입 > 에이닷 연결 해제 선택 > 연결 해제 팝업 확인 선택 > 팝업 확인 선택 > 프로필 관리 확인 선택 > 닉네임 옆 에아닷 로고 없어진거 확인

    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skb.smartrc:id/iv_my
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skb.smartrc:id/tv_connect_adot
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Wait Until Element Is Visible    Xpath=//android.widget.TextView[@text="에이닷 연결"]
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.widget.Button[@text="모두 동의"]
    Sleep    3
    Wait Until Keyword Succeeds    1 min    3 sec    Wait Until Element Is Visible    com.skb.smartrc:id/tv_adot_connect_complete_title    #에이닷 연결 완료 팝업 타이틀
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skb.smartrc:id/btn_confirm    #팝업 확인 버튼
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Wait Until Element Is Visible    com.skb.smartrc:id/iv_adot_icon
    Sleep    1

    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skb.smartrc:id/iv_modify
    Wait Until Keyword Succeeds    1 min    3 sec    Wait Until Element Is Visible    com.skb.smartrc:id/tv_my_adot_disconnect    #에이닷 연결 중인 것 확인
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skb.smartrc:id/tv_my_adot_disconnect
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Wait Until Element Is Visible    com.skb.smartrc:id/tv_title    #오류 날 시 변경된 해당 ID 값 변경 요망
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skb.smartrc:id/btn_right
    Sleep    1
    Press Keycode    4
    Page Should Not Contain Element    com.skb.smartrc:id/iv_adot_icon
    Page Should Not Contain Element    com.skb.smartrc:id/tv_my_adot_connect

    