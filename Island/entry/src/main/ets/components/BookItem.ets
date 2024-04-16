import { Level } from '@ohos/hypium/src/main/Constant';
import { BookItemType } from '../models'

@Component
struct BookItem {
  @Prop bookItem: BookItemType;

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Image(this.bookItem.image)
        .width('100%')
        .height('100%')
        // .objectFit(ImageFit.Fill)

      Column() {
        Text(this.bookItem.title)
          .fontSize(12)
          .fontColor('#1f1f1f')
          .width('100%')
          .textAlign(TextAlign.Start)
          .maxLines(1)
          .textOverflow({
            overflow: TextOverflow.Ellipsis
          })
        Text(this.bookItem.author)
          .fontSize(10)
          .fontColor('#999')
          .width('100%')
          .textAlign(TextAlign.Start)
          .maxLines(1)
          .textOverflow({
            overflow: TextOverflow.Ellipsis
          })
        Text() {
          Span(`${this.bookItem.fav_nums} 喜欢`)
          Span('·')
          Span('68 短评')
        }
        .width('100%')
        .textAlign(TextAlign.End)
        .margin({ top: 12 })
        .fontSize(10)
        .fontColor('#bbb')
      }
      .width('100%')
      .height(69)
      .padding({ top: 9, right: 11, bottom: 9, left: 11 })
      .backgroundColor(Color.White)
      .offset({
        y: 1
      })
    }
    .width(120)
    .height(180)
    .margin({ bottom: 30 })
    .borderRadius(3)
    /*.shadow({

    })*/
  }
}

export { BookItem }