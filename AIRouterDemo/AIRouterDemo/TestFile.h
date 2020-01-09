//
//  TestFile.h
//  AIRouterDemo
//
//  Created by mal on 2019/12/13.
//  Copyright © 2019 mal. All rights reserved.
//

#ifndef TestFile_h
#define TestFile_h

func setSubmitForm(loginFields: [XYJMobilSuanhuaLoginField]) {
    self.loginView.logFieldDatas = loginFields
    // 设置手机号码
    loginFields.forEach({ (loginField) in
        if loginField.name == "phoneNo" {
            self.vm.phoneNo.value = loginField.value ?? ""
        }
    })
    self.btnTapbind()
    self.countdown()
    // 确定登录类型后再进行按钮高亮处理
    self.vm.authenBtnBind()
    
    self.formFieldbind()
    
    // 提交按钮高亮绑定(要在 authenBtnBind()后，再设置)
    self.vm.authenBtnEnable?.asObservable().bind(to: self.loginView.submitBtn.rx.enabled).disposed(by: self.vm.disposeBag!)
    self.loginView.submitBtn.rx.tap.bind(to: self.vm.authenBtnTap!).disposed(by: self.vm.disposeBag!)
    self.vm.authenTapResult?.subscribe(onNext: { (formResult) in
        let result = self.detailForm(result: formResult)
        if result.0 {
            self.submitform(parameters: result.1)
        }
    }).disposed(by: self.vm.disposeBag!)
}


#endif /* TestFile_h */
