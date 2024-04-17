@Component
struct Like {
  build() {
    Scroll() {
      Column() {
        Stack({ alignContent: Alignment.Bottom }) {
          Image($r('app.media.like_bg'))
            .width('100%')
            .height(287)

          Row() {
            Column({ space: 4 }) {
              Image($r('app.media.about_icon'))
                .width(17)
                .height(17)
              Text('关于我们')
                .fontSize(12)
                .fontColor('#999')
            }

            Column() {
              Text('17')
                .fontSize(18)
                .fontColor(Color.Black)
              Text('我的书单')
                .fontSize(12)
                .fontColor('#999')
            }
          }
          .width('100%')
          .padding({ left: 50, right: 50, bottom: 40 })
          .justifyContent(FlexAlign.SpaceBetween)
        }

        Text('没有喜欢的列表~')
          .fontSize(18)
          .fontColor('#999')
          .margin({ top: 80 })
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#f5f5f5')
      .justifyContent(FlexAlign.Start)
    }
    .width('100%')
    .height('100%')
  }
}

export { Like }