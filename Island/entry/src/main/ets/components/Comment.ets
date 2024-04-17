import { Stars } from './Stars'

@Component
struct Comment {
  build() {
    Row() {
      Row({ space: 5 }) {
        Image($r('app.media.write_icon'))
          .width(12)
          .height(12)
        TextInput({ placeholder: '留下你的短评~' })
          .layoutWeight(1)
          .height('100%')
          .padding(0)
          .backgroundColor(Color.Transparent)
          .fontColor(14)
      }
      .width(200)
      .height(27)
      .padding({ left: 10, right: 10 })
      .border({
        color: Color.Black,
        width: 1
      })
      .borderRadius(27)

      Row({ space: 10 }) {
        Stars()

        Image($r('app.media.share_icon'))
          .width(14)
          .height(14)
      }
    }
    .width('100%')
    .height(43)
    .padding({ left: 16, right: 16 })
    .justifyContent(FlexAlign.SpaceBetween)
    .backgroundColor('#fff')
    .border({
      color: '#eee',
      width: {
        top: 1
      }
    })
  }
}

export { Comment }