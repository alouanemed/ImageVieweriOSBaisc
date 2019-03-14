import SwiftMessages

extension SwiftMessages {
    static func configs() -> SwiftMessages.Config   {
        var config = SwiftMessages.Config()
        config.dimMode = .gray(interactive: true)
        config.preferredStatusBarStyle = .lightContent
        config.presentationStyle = .bottom
        return config
    }
    
    static func showSuccessMessage(with body: String){
        let view = MessageView.viewFromNib(layout: .cardView)
        view.configureTheme(.success)
        view.configureDropShadow()
        view.configureContent(title: "Success", body: body)
        view.button?.isHidden = true
        show(config: configs(), view: view)
    }
    
     
}
