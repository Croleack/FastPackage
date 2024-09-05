# OneSPM (iOS)

<!--BEGIN_DESCRIPTION-->
TwoSPM - представляет собой мини-приложение для досуга
<!--END_DESCRIPTION-->

## Установка и интеграция

1. Для установки выполните следующие действия:

Добавьте пакет в зависимости вашего проекта, перейдя в файл проекта на вкладке «Зависимости пакета» и щелкнув значок «плюс».

<img width="1404" alt="1" src="https://github.com/user-attachments/assets/7a0cd89e-963f-41ab-940e-9cedeb1c9c8b">

   
2. В открывшемся окне введите ссылку на Git-репозиторий, где находится SDK. Слева вы увидите значок пакета, выберите «До следующей основной версии» в поле «Правило зависимостей» и укажите текущую версию пакета как «1.0.2». После этого нажмите кнопку «Добавить пакет», и вы увидите всплывающее окно с информацией о статусе пакета.

 <img width="1090" alt="2" src="https://github.com/user-attachments/assets/cb6e1052-255a-460f-a621-63814045684a">
  
    
3. После успешного добавления пакета в ваш проект вы увидите пакеты и зависимости FastPackage, используемые для работы с SDK, в иерархии вашего проекта.

4. Добавив пакет, вы можете увидеть его составные части, а именно View и ViewController доступной для использования, ниже представлен код, позволяющий продемонстировать работоспособность спм:

```swift
import UIKit
import CurrencyPackage
import FastPackage

enum MiniAppType {
    case fastViewController
    case currencyViewController

    func getView() -> UIView {
        switch self {
        case .fastViewController:
            return FirstMiniAppView()
        case .currencyViewController:
            return CurrencyView()
        }
    }

    func getViewController() -> UIViewController {
        switch self {
        case .fastViewController:
            return PlayViewController()
        case .currencyViewController:
            return CurrencyViewController()
        }
    }
}
```

5. Примеры демонстрирующие как выглядит мини-приложение 

<img width="701" alt="Снимок экрана 2024-09-05 в 18 54 30" src="https://github.com/user-attachments/assets/1880f74f-6410-4796-b42a-98a545a534e0">
<img width="848" alt="Снимок экрана 2024-09-05 в 18 54 47" src="https://github.com/user-attachments/assets/7bf44546-824a-4076-afa4-e32b282261ad">

