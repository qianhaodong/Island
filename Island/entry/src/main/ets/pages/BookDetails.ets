import { Comment } from '../components/Comment';
import { BookDetailsType, BookItemType, BookLikeStatus, DataModel } from '../models';
import { router } from '@kit.ArkUI';
import { getBookDetails, getBookLikeStatus } from '../api/book';

// 获取页面路由参数
const params: DataModel = router.getParams() as DataModel;
const id = params.id;

@Styles function sectionStyle() {
  .backgroundColor('#fff')
  .border({
    color: '#f5f5f5',
    width: {
      bottom: 10
    }
  })
}
@Extend(Text) function titleStyle() {
  .width('100%')
  .textAlign(TextAlign.Center)
  .fontSize(16)
  .fontColor('#292929')
  .padding({ top: 10, bottom: 10 })
}

@Entry
@Component
struct BookDetails {
  @State bookDetails: BookDetailsType | null = null;
  @State commentList: string[] = [
    '你好哇，李银河 +234',
    '浪漫爱情 +453',
    '你要是喜欢别人我会哭 +228',
    '我还是喜欢你 +453',
    '我这张丑脸上就泛起微笑 +666',
    '浪漫爱情 +566',
    '233333 +122'
  ];
  @State bookLikeStatus: BookLikeStatus | null = null;

  async aboutToAppear() {
    getBookDetails(id).then((res: BookDetailsType) => {
      this.bookDetails = res;
    });

    getBookLikeStatus(id).then((res: BookLikeStatus) => {
      this.bookLikeStatus = res;
    });
  }

  build() {
    Column() {
      Scroll() {
        Column() {
          Column() {
            Image(this.bookDetails?.image)
              .width(100)
              .height(150)
              .margin({ bottom: 12 })
            Text(this.bookDetails?.title)
              .fontSize(19)
              .fontColor(Color.Black)
            Text(this.bookDetails?.author[0])
              .fontSize(14)
              .fontColor('#999')
          }
          .sectionStyle()
          .width('100%')
          .padding({ top: 20, bottom: 20 })
          .alignItems(HorizontalAlign.Center)

          Column() {
            Text('短评')
              .titleStyle()
            Flex({
              wrap: FlexWrap.Wrap
            }) {
              ForEach(this.commentList, (item: string) => {
                Text(item)
                  .fontSize(12)
                  .fontColor('#666')
                  .backgroundColor('#f7f7f7')
                  .borderRadius(30)
                  .padding({ top: 6, right: 12, bottom: 6, left: 12 })
                  .margin({ right: 6, bottom: 10 })
              })
            }
          }
          .sectionStyle()
          .padding({ right: 10, bottom: 4, left: 10 })

          Column() {
            Text('内容简介')
              .titleStyle()

            Text(this.bookDetails?.summary)
              .fontSize(14)
              .fontColor('#666')
              // .letterSpacing(1)
              .lineHeight(24)
          }
          .sectionStyle()
          .padding({ right: 20, bottom: 10, left: 20 })

          Column() {
            Text('书本信息')
              .titleStyle()

            Flex() {
              Column({ space: 2 }) {
                Text('出版社')
                  .fontSize(12)
                  .fontColor('#999')
                Text('出版年')
                  .fontSize(12)
                  .fontColor('#999')
                Text('页数')
                  .fontSize(12)
                  .fontColor('#999')
                Text('定价')
                  .fontSize(12)
                  .fontColor('#999')
                Text('装帧')
                  .fontSize(12)
                  .fontColor('#999')
              }
              .margin({ right: 10 })
              .alignItems(HorizontalAlign.Start)

              Column({ space: 2 }) {
                Text(this.bookDetails?.publisher)
                  .fontSize(12)
                  .fontColor('#666')
                Text(this.bookDetails?.pubdate)
                  .fontSize(12)
                  .fontColor('#666')
                Text(this.bookDetails?.pages)
                  .fontSize(12)
                  .fontColor('#666')
                Text(this.bookDetails?.price)
                  .fontSize(12)
                  .fontColor('#666')
                Text(this.bookDetails?.binding)
                  .fontSize(12)
                  .fontColor('#666')
              }
              .alignItems(HorizontalAlign.Start)
            }
          }
          .sectionStyle()
          .width('100%')
          .alignItems(HorizontalAlign.Start)
          .padding({ right: 20, bottom: 10, left: 20 })
        }
      }
      .width('100%')
      .layoutWeight(1)

      Comment({
        itemType: 400,
        likeStatus: this.bookLikeStatus
      })
    }
    .width('100%')
    .height('100%')
  }
}