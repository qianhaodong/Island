import { getBookLikeNums, getClassicLikeList } from '../api/like'
import { LikeItem } from '../components/LikeItem';
import { ClassicType } from '../models';
import { router, SwipeRefresher } from '@kit.ArkUI';

@Component
struct Like {
  @State likeNums: number = 0;
  @State classicLikeList: ClassicType[] = [];
  @State isLoading: boolean = false;
  @State isEmpty: boolean = false;
  @State isRefreshing: boolean = false;

  aboutToAppear() {
    this.isLoading = true;
    this.getData();
  }

  getData() {
    getBookLikeNums().then((res: number) => {
      this.likeNums = res;
    });

    getClassicLikeList().then((res: ClassicType[]) => {
      this.classicLikeList = res;
      this.isLoading = false;
      this.isEmpty = false;

      // 判断列表为空
      if (!this.classicLikeList.length) {
        this.isEmpty = true;
      }
    })
  }

  build() {
    Refresh({
      refreshing: $$this.isRefreshing
    }) {
      Scroll() {
        Column() {
          Stack({ alignContent: Alignment.Bottom }) {
            Image($r('app.media.like_bg'))
              .width('100%')
              .height(287)

            Image($r('app.media.author'))
              .width(72)
              .height(72)
              .borderRadius(100)
              .offset({
                y: -94
              })

            Row() {
              Column({ space: 4 }) {
                Image($r('app.media.about_icon'))
                  .width(17)
                  .height(17)
                Text('关于我们')
                  .fontSize(12)
                  .fontColor('#999')
              }
              .onClick(() => {
                AlertDialog.show({
                  title: '关于我们',
                  message: '参考慕课网七月老师小程序课程，旧岛小程序项目。',
                  alignment: DialogAlignment.Center
                })
              })

              Column() {
                Text(this.likeNums.toString())
                  .fontSize(18)
                  .fontColor(Color.Black)
                Text('我的书单')
                  .fontSize(12)
                  .fontColor('#999')
              }
              .onClick(() => {

              })
            }
            .width('100%')
            .padding({ left: 50, right: 50, bottom: 40 })
            .justifyContent(FlexAlign.SpaceBetween)
          }

          if (this.isLoading) {
            SwipeRefresher({
              content: '',
              isLoading: this.isLoading
            })
          } else {
            if (this.isEmpty) {
              Text('暂时没有喜欢的内容~')
                .fontSize(18)
                .fontColor('#999')
                .margin({ top: 80 })
            }

            if (this.classicLikeList.length) {
              Image($r('app.media.like_title_icon'))
                .width(49)
                .height(21)
                .objectFit(ImageFit.Fill)
                .margin(10)

              Flex({
                wrap: FlexWrap.Wrap,
                justifyContent: FlexAlign.SpaceBetween
              }) {
                ForEach(this.classicLikeList, (item: ClassicType) => {
                  LikeItem({
                    likeItem: item
                  })
                    .width('48%')
                    .onClick(() => {
                      router.pushUrl({
                        url: 'pages/ClassicDetails',
                        params: item
                      })
                    })
                })
              }
              .padding({ left: 18, right: 18 })
            }
          }
        }
        .width('100%')
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#f5f5f5')
      .align(Alignment.TopStart)
    }
    .onRefreshing(() => {
      this.getData();

      setTimeout(() => {
        this.isRefreshing = false;
      }, 1000);
    })
  }
}

export { Like }