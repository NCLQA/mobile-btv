*** Settings ***
Library           AppiumLibrary
Library           Process     
Library           String
Library           OperatingSystem

Suite Setup       모바일 btv 실행
Test Setup        앱 재실행
Suite Teardown    앱 재실행
Resource          mbtv.resource


*** Test Cases ***

# 모바일 btv 실행
ㅎㅎㅎ
    [Tags]    홈    BAT    CR
    Wait Until Element Is Visible    id=com.skb.smartrc:id/ivMyNoti
    Click Element    id=com.skb.smartrc:id/ivMyNoti   
    Wait Until Element Is Visible    id=com.skb.smartrc:id/title

텍스트 입력
    [Tags]    검색
    시청 연령 제한 체크
    Sleep    1
    Click Element    com.skb.smartrc:id/settings_auth_adult_auth_chk
    비밀번호 입력 (1111)
    Sleep    1
    Click Element    com.skb.smartrc:id/btn_right
    Sleep    1
    Click Element    com.skb.smartrc:id/settings_item_auth_adult_age19
    비밀번호 입력 (1111)
    Sleep    1
    Click Element    com.skb.smartrc:id/btn_right
    Sleep    1
    Click Element    com.skb.smartrc:id/icBack
    Sleep    1
    Click Element    com.skb.smartrc:id/icBack
    Sleep    1
    Click Element    id=com.skb.smartrc:id/icSearch
    Sleep    1
    검색어 검색    id=com.skb.smartrc:id/top_search_bar    존윅 4
    Sleep    1
    Click Element    Xpath=//android.widget.TextView[@text = '존 윅 4']
    Sleep    1
    Click Element    Xpath=//android.view.ViewGroup[@content-desc="존 윅 4"]/android.view.ViewGroup/android.widget.ImageView[1]
    Sleep    1
    Click Element    Xpath=//hierarchy/android.widget.FrameLayout/android.widget.FrameLayout/android.widget.FrameLayout/android.widget.RelativeLayout/android.widget.LinearLayout/android.widget.RelativeLayout/android.widget.LinearLayout
    Sleep    1
    Run Process    adb logcat -c    shell=True
    Run Keyword And Ignore Error    Remove File    D://RFA/log.txt
    비밀번호 입력 (1111)
    Sleep    2
    ${log}    Run Process    adb shell logcat -t 3000 >> D://RFA/log.txt    shell=True
    ${String}    Get File    D://RFA/log.txt
    Should Contain    ${String}    ${존윅4 재생 로그}
    Element Should Contain Text    id=com.skb.smartrc:id/tv_title    존 윅 4

