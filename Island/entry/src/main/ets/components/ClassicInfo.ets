import { Stars } from './Stars'

@Component
struct ClassicInfo {
  build() {
    Row() {
      Row({ space: 6 }) {
        Row() {
          Text('No.')
            .fontSize(18)
            .lineHeight(40)
          Text('8')
            .fontWeight(FontWeight.Bold)
            .fontSize(32)
            .lineHeight(40)
        }
        .alignItems(VerticalAlign.Bottom)
        Row()
          .width(2)
          .height(22)
          .backgroundColor(Color.Black)
        Column() {
          Text('六月')
            .fontSize(14)
          Text('2019')
            .fontSize(12)
        }
        .alignItems(HorizontalAlign.Start)
      }

      Row({ space: 20 }) {
        Stars()
        Image($r('app.media.share_icon'))
          .width(14)
          .height(14)
      }
    }
    .width('100%')
    .height(60)
    .padding({ left: 16, right: 16 })
    .justifyContent(FlexAlign.SpaceBetween)
  }
}

export { ClassicInfo }