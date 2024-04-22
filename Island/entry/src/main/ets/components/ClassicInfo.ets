import { ClassicType } from '../models'
import { Stars } from './Stars'

@Component
struct ClassicInfo {
  @Prop classicData: ClassicType | null;
  @State year: string = '';
  @State month: string = '';

  updateData: () => void = () => {};

  aboutToAppear() {
    // 获取当日期：年、月
    const date = new Date();
    const month = date.getMonth() + 1;
    this.year = date.getFullYear().toString();

    switch (month) {
      case 1:
        this.month = '一月';
        break;
      case 2:
        this.month = '二月';
        break;
      case 3:
        this.month = '三月';
        break;
      case 4:
        this.month = '四月';
        break;
      case 5:
        this.month = '五月';
        break;
      case 6:
        this.month = '六月';
        break;
      case 7:
        this.month = '七月';
        break;
      case 8:
        this.month = '八月';
        break;
      case 9:
        this.month = '九月';
        break;
      case 10:
        this.month = '十月';
        break;
      case 11:
        this.month = '十一月';
        break;
      case 12:
        this.month = '十二月';
        break;
      default:
        this.month = '九月';
        break;
    }
  }

  build() {
    Row() {
      Row({ space: 6 }) {
        Row() {
          Text('No.')
            .fontSize(18)
            .lineHeight(40)
          Text(this.classicData?.index?.toString())
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
          Text(this.month)
            .fontSize((this.month === '十二月' || this.month === '十一月') ? 10 : 14)
          Text(this.year)
            .fontSize(12)
        }
        .alignItems(HorizontalAlign.Start)
      }

      Row({ space: 20 }) {
        Stars({
          itemId: this.classicData?.id,
          itemType: this.classicData?.type,
          likeStatus: !!this.classicData?.like_status,
          favNums: this.classicData?.fav_nums,
          updateData: () => {
            this.updateData();
          }
        })
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