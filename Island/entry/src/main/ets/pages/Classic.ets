import { emitter } from '@kit.BasicServicesKit';
import { getClassicDetails, getClassicLatest, getClassicNext, getClassicPrevious } from '../api/classic';
import { ClassicType } from '../models'
import { ClassicContent } from '../components/ClassicContent'
import { ClassicInfo } from '../components/ClassicInfo'
import { EmitEventType } from '../constants';
import { StoreManager } from '../utils/store';

@Component
struct Classic {
  @State classicData: ClassicType | null = null;
  @State btnEnabled: boolean = true;

  async aboutToAppear() {
    // 获取最新一期期刊缓存
    this.classicData = StoreManager.getClassicLatest();

    // 请求最新一期期刊数据
    getClassicLatest()
      .then((res: ClassicType) => {
        this.classicData = res;

        // 更新最新一期期刊缓存
        StoreManager.setClassicLatest(res);
      })

    // 订阅tab显示事件
    emitter.on({ eventId: EmitEventType.TAB_CLASSIC_SHOW }, () => {
      this.updateData();
    });

    // 订阅tab隐藏事件
    /*emitter.on({ eventId: EmitEventType.TAB_CLASSIC_HIDE }, () => {
      console.log('TabContent-hide');
    });*/
  }

  // 更新当前期刊数据
  async updateData() {
    this.classicData = await getClassicDetails(this.classicData?.type as number, this.classicData?.id as number)
  }

  build() {
    Column() {
      ClassicInfo({
        classicData: this.classicData,
        updateData: () => {
          this.updateData();
        }
      })

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
            .onClick(() => {
              if (this.classicData?.index === 8) return;

              // 添加节流控制
              this.btnEnabled = false;
              getClassicNext(this.classicData?.index as number)
                .then((res: ClassicType) => {
                  this.classicData = res;
                })
                .finally(() => {
                  this.btnEnabled = true;
                })
            })
            .enabled(this.btnEnabled)

          Text(this.classicData?.title)
            .fontSize(14)

          Image($r('app.media.next_icon'))
            .width(12)
            .opacity(this.classicData?.index === 1 ? 0.3 : 1)
            .onClick(() => {
              if (this.classicData?.index === 1) return;

              this.btnEnabled = false;
              getClassicPrevious(this.classicData?.index as number)
                .then((res: ClassicType) => {
                  this.classicData = res;
                })
                .finally(() => {
                  this.btnEnabled = true;
                })
            })
            .enabled(this.btnEnabled)
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