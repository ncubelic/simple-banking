import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
       configureAppearance()
        
        return true
    }
    
    func configureAppearance() {
        let navBar = UINavigationBar.appearance()
        navBar.barTintColor = .navigationBarBlue
        navBar.tintColor = .white
        navBar.isTranslucent = false
        navBar.barStyle = .black
    }
}

