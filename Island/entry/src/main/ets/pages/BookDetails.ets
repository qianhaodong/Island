import { Comment } from '../components/Comment';
import { BookCommentItem, BookDetailsType, BookItemType, BookLikeStatus, DataModel } from '../models';
import { router } from '@kit.ArkUI';
import { getBookDetails, getBookLikeStatus, getBookShortComment } from '../api/book';

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
  @State commentList: BookCommentItem[] = [];
  @State bookLikeStatus: BookLikeStatus | null = null;

  async aboutToAppear() {
    // 获取书籍详情
    getBookDetails(id).then((res: BookDetailsType) => {
      this.bookDetails = res;
    });

    // 获取点赞状态
    getBookLikeStatus(id).then((res: BookLikeStatus) => {
      this.bookLikeStatus = res;
    });

    // 获取书籍短评
    getBookShortComment(id).then((res: BookCommentItem[]) => {
      this.commentList = res;
    });
  }

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        Scroll() {
          Column() {
            Column() {
              Image(this.bookDetails?.image)
                .width(100)
                .height(150)
                .margin({ bottom: 12 })
                .shadow({
                  radius: 28,
                  offsetX: 2,
                  offsetY: 2,
                  color: '#eee',
                })
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

            if (this.commentList.length) {
              Column() {
                Text('短评')
                  .titleStyle()
                Flex({
                  wrap: FlexWrap.Wrap
                }) {
                  ForEach(this.commentList, (item: BookCommentItem, index) => {
                    Text(`${item.content} +${item.nums}`)
                      .fontSize(12)
                      .fontColor('#666')
                      .backgroundColor(index === 0 ? '#FFFADD' : index === 1 ? '#EFFAFF' : '#f7f7f7')
                      .borderRadius(30)
                      .padding({ top: 6, right: 12, bottom: 6, left: 12 })
                      .margin({ right: 6, bottom: 10 })
                  })
                }
              }
              .sectionStyle()
              .padding({ right: 16, bottom: 4, left: 16 })
            }

            Column() {
              Text('内容简介')
                .titleStyle()

              Text(this.bookDetails?.summary)
                .fontSize(14)
                .fontColor('#666')
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
          likeStatus: this.bookLikeStatus,
          updateDate: () => {
            // 更新点赞状态
            getBookLikeStatus(id).then((res: BookLikeStatus) => {
              this.bookLikeStatus = res;
            });
          }
        })
      }
      .width('100%')
      .height('100%')

      /*Panel(true) {
        Text('panel')
      }
      .dragBar(false)*/
    }
    .width('100%')
    .height('100%')
  }
}