# Alarm_Project

### 사용 언어

- Swift(SwiftIUI)

### 라이브러리 & 프레임워크

- UserNotifications - 푸시알림
- CoreData - 데이터베이스

📊 주요 기능
기능	이름	설명	키워드
class	AlertTimer
TimerClass	- Timer의 클래스
- 타이머 시작,정지,일시정지 기능
- 타이머 푸시 알림 기능	ObservableObject
UNUserNotifications
	StopWatchClass	- StopWatch의 클래스
- 기록 시간 리스트 추가	ObservableObject
Entity
	TimeListStore	- Coredata 호출 성공 유무	ObservableObject
UserNotifications
CoreData
	List
ContentList
StopWatchStoreList	- List를 사용하기 위한 initalize	Identifiable
ObservableObject
	FormatterClass	- 날짜 formatter 설정	DateFormatter
Delegate	AppDelegate	- 앱실행 시 Delegate 설정	NSObject
UIApplicationDelegate
