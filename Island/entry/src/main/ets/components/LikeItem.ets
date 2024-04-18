import { ClassicType } from '../models'
import { Stars } from './Stars';

@Component
struct LikeItem {
  @Prop likeItem: ClassicType | null = null;

  getLabel(type?: number) {
    let label = '';
    switch (type) {
      case 100:
        label = '电影';
        break;
      case 200:
        label = '音乐';
        break;
      case 300:
        label = '诗句';
        break;
      default:
        label = '未知';
    }

    return label;
  }

  build() {
    Column() {
      Row() {
        Row() {
          Text(this.getLabel(this.likeItem?.type))
            .fontColor('#333')
            .fontSize(12)
        }
        .width(36)
        .height(20)
        .backgroundColor('#f2f2f2')
        .justifyContent(FlexAlign.Center)

        Stars({
          itemId: this.likeItem?.id,
          itemType: this.likeItem?.type,
          favNums: this.likeItem?.fav_nums,
          likeStatus: !!this.likeItem?.like_status
        })
      }
      .width('100%')
      .height(40)
      .padding({ left: 10, right: 10 })
      .justifyContent(FlexAlign.SpaceBetween)

      Column() {
        if (this.likeItem?.type === 200) {
          Stack({ alignContent: Alignment.Center }) {
            Image(this.likeItem?.image)
              .width(100)
              .height(100)
              .borderRadius(100)

            Row()
              .width(34)
              .height(34)
              .borderRadius(34)
              .backgroundColor(Color.White)
          }
        } else {
          Image(this.likeItem?.image)
            .width('100%')
            .height('100%')
        }
      }
      .width('100%')
      .height(120)

      Text(this.likeItem?.content)
        .fontSize(14)
        .fontColor('#999')
        .lineHeight(21)
        .padding({ top: 16, right: 10, left: 10 })
        .maxLines(2)
        .textOverflow({
          overflow: TextOverflow.Ellipsis
        })
    }
    .width('100%')
    .height(235)
    .backgroundColor(Color.White)
    .margin({ bottom: 15 })
  }
}

export { LikeItem }