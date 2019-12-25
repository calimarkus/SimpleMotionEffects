//
//  UIAlertController+SimpleUIKit.m
//  SimpleUIKit ExampleProject
//
//

#import "UIAlertController+SimpleUIKit.h"

@implementation UIAlertController (SimpleAPI)

+ (UIAlertController *)presentFromViewController:(UIViewController *)viewController
                        withTitle:(NSString *)title
                          message:(NSString *)message
          confirmationButtonTitle:(NSString *)confirmationButtonTitle
{
  return [self presentFromViewController:viewController
                          preferredStyle:UIAlertControllerStyleAlert
                               withTitle:title
                                 message:message
                                 buttons:@[[SimpleAlertButton defaultButtonWithTitle:confirmationButtonTitle]]
                           buttonHandler:nil];
}

+ (UIAlertController *)presentFromViewController:(UIViewController *)viewController
                                  preferredStyle:(UIAlertControllerStyle)preferredStyle
                                       withTitle:(NSString *)title
                                         message:(NSString *)message
                                         buttons:(NSArray<SimpleAlertButton *> *)buttons
                                   buttonHandler:(void (^)(UIAlertAction *))buttonHandler
{
  UIAlertController *alertController = [UIAlertController
                                        alertControllerWithTitle:title
                                        message:message
                                        preferredStyle:preferredStyle];

  for (SimpleAlertButton *simpleButton in buttons) {
    [alertController addAction:ActionForButton(simpleButton, buttonHandler)];
  }

  [viewController presentViewController:alertController animated:YES completion:nil];
  return alertController;
}

static UIAlertAction *ActionForButton(SimpleAlertButton *button, void (^buttonHandler)(UIAlertAction *))
{
  __block UIAlertAction *action;
  [button matchDefaultButton:^(NSString *title) {
    action = [UIAlertAction actionWithTitle:title style:UIAlertActionStyleDefault handler:buttonHandler];
  } cancelButton:^(NSString *title) {
    action = [UIAlertAction actionWithTitle:title style:UIAlertActionStyleCancel handler:buttonHandler];
  } destructiveButton:^(NSString *title) {
    action = [UIAlertAction actionWithTitle:title style:UIAlertActionStyleDestructive handler:buttonHandler];
  }];
  return action;
}

@end
