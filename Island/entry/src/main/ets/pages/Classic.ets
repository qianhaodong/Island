import { getClassicLatest, getClassicPrevious } from '../api';
import { ClassicType } from '../models'

import { ClassicContent } from '../components/ClassicContent'
import { ClassicInfo } from '../components/ClassicInfo'

@Component
struct Classic {
  @State classicData: ClassicType | null = null;

  async aboutToAppear() {
    this.classicData = await getClassicLatest();
  }

  build() {
    Column() {
      ClassicInfo()

      Column() {
        ClassicContent({
          classicData: this.classicData
        })
          .layoutWeight(1)

        // 切换按钮
        Row() {
          Image($r('app.media.prev_icon'))
            .width(12)
            .opacity(this.classicData?.index === 8 ? 0.3 : 1)
            .onClick(async () => {
              if (this.classicData?.index === 8) return;
              this.classicData = await getClassicPrevious(this.classicData?.index as number + 2)
            })
          Text(this.classicData?.title)
            .fontSize(14)
          Image($r('app.media.next_icon'))
            .width(12)
            .opacity(this.classicData?.index === 1 ? 0.3 : 1)
            .onClick(async () => {
              if (this.classicData?.index === 1) return;
              this.classicData = await getClassicPrevious(this.classicData?.index as number)
            })
        }
        .width(300)
        .height(40)
        .padding({ left: 10, right: 10 })
        .margin({ bottom: 20 })
        .backgroundColor('#f7f7f7')
        .justifyContent(FlexAlign.SpaceBetween)
      }
      .width('100%')
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
  }
}

export { Classic }