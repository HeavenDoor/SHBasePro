require('UIView, UIColor, UILabel')
defineClass('TestViewController', {
  // replace the -genView method
  genView: function() {
    var view = self.ORIGgenView();
    view.setBackgroundColor(UIColor.greenColor())
    var label = UILabel.alloc().initWithFrame(view.frame());
    label.setText("JSPatch");
    label.setTextAlignment(1);
    view.addSubview(label);
    return view;
  },
            
  sayHello: function(){
    self.ORIGsayShenghai();
  },
            
  sayShenghai: function(){
    self.ORIGsayHello();
  }
});