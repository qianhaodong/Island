import { ClassicInfo } from '../components/ClassicInfo';
import { ClassicType } from '../models';
import { router } from '@kit.ArkUI';
import { getClassicDetails } from '../api/classic';
import { ClassicContent } from '../components/ClassicContent';

@Entry
@Component
struct ClassicDetails {
  @State classicData: ClassicType | null = null;

  async aboutToAppear() {
    const params: ClassicType = router.getParams() as ClassicType;
    this.classicData = await getClassicDetails(params.type, params.id) as ClassicType;
  }

  build() {
    Column() {
      ClassicInfo({
        classicData: this.classicData
      })

      Column() {
        ClassicContent({
          classicData: this.classicData
        })

        Text(this.classicData?.title)
          .margin({ bottom: 40 })
      }
      .width('100%')
      .layoutWeight(1)
      .justifyContent(FlexAlign.SpaceBetween)
    }
    .width('100%')
    .height('100%')
  }
}