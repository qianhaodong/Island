import { ClassicType } from '../models';

@Component
struct ClassicContent {
  @Prop @Watch('handleDataChange') classicData: ClassicType | null;
  @State category: string = 'movie';
  @State musicShow: boolean = false;

  handleDataChange() {
    switch (this.classicData?.type) {
      case 100:
        this.category = 'movie';
        this.musicShow = false;
        break;
      case 200:
        this.category = 'music';
        this.musicShow = true;
        break;
      case 300:
        this.category = 'poetry';
        this.musicShow = false;
        break;
    }
  }

  build() {
    Column() {
      Stack({ alignContent: Alignment.BottomStart }) {
        Column() {
          if (this.musicShow) {
            Stack({ alignContent: Alignment.Center }) {
              Image(this.classicData?.image)
                .width(210)
                .height(210)
                .borderRadius(210)

              Image($r('app.media.play_icon'))
                .width(60)
                .height(60)
            }

          } else {
            Image(this.classicData?.image)
              .width('100%')
              .height('100%')
              .objectFit(ImageFit.Fill)
          }
        }
        .width('100%')
        .height('100%')
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)

        Image($r(`app.media.${this.category}`))
          .width(23)
          .height(71)
          .offset({
            x: 15,
            y: 42
          })
          .objectFit(ImageFit.Fill)
      }
      .width('100%')
      .height(250)

      Text(this.classicData?.content)
        .fontSize(19)
        .lineHeight(24)
        .padding({ top: 70, left: 45, right: 45 })
    }
    .width('100%')
  }
}

export { ClassicContent }