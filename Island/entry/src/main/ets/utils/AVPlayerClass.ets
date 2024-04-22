import { media } from '@kit.MediaKit'
import { BusinessError, emitter } from '@kit.BasicServicesKit';
import { PlayStateType } from '../models';
import { EmitEventType } from '../constants';

export class AVPlayerClass {
  // 1、创建一个播放器
  static player: media.AVPlayer | null = null

  // 播放状态
  static isPlay: boolean = false
  // 歌曲播放进度时长
  static time: number = 0
  // 播放索引
  static playIndex: number = 0

  // 2、初始化
  static async init() {
    AVPlayerClass.player = await media.createAVPlayer();

    // 监听播放器错误信息
    AVPlayerClass.player.on('error', (err: BusinessError) => {
      console.error(`Invoke avPlayer failed, code is ${err.code}, message is ${err.message}`);
    });

    // 监听播放状态事件（状态机）
    AVPlayerClass.player.on('stateChange', (state: string) => {
      switch (state) {
        case 'initialized':
          AVPlayerClass.player?.prepare();
          break;
        case 'prepared':
          AVPlayerClass.player?.play();
          AVPlayerClass.isPlay = true;
          AVPlayerClass.updateState();
          break;
        case 'completed':
          // 播放结束，更新状态
          AVPlayerClass.isPlay = false;
          AVPlayerClass.player?.reset();
          AVPlayerClass.updateState();
          break;
        default:
          break;
      }
    });

    // 监听播放进度事件，获取当前播放进度
    AVPlayerClass.player.on('timeUpdate', (time: number) => {
      if (time !== 0 && time !== AVPlayerClass.time) {
        AVPlayerClass.time = time;
      }
    });

    // 监听设置播放时长
    AVPlayerClass.player.on('seekDone', () => {
      AVPlayerClass.player?.play();
      AVPlayerClass.isPlay = true;
      AVPlayerClass.updateState();
    })
  }

  // 单曲播放
  static async singlePlay(url: string, index: number) {
    if (AVPlayerClass.player) {
      // 判断是否是当前播放歌曲
      if (url === AVPlayerClass.player.url) {
        // 是：继续播放
        AVPlayerClass.player.seek(AVPlayerClass.time);
      } else {
        // 否：切换歌曲
        AVPlayerClass.changePlay(url, index);
      }
    }
  }

  static async changePlay(url: string, index: number) {
    if (AVPlayerClass.player) {
      // 将播放器设置为闲置状态
      await AVPlayerClass.player.reset();

      AVPlayerClass.player.url = url;
      AVPlayerClass.playIndex = index;
    }
  }

  // 暂停播放
  static pausePlay() {
    if (AVPlayerClass.player) {
      AVPlayerClass.player.pause();
      AVPlayerClass.isPlay = false;
      AVPlayerClass.updateState();
    }
  }

  // 更新页面状态
  static updateState() {
    const playState: PlayStateType = {
      isPlay: AVPlayerClass.isPlay,
      playIndex: AVPlayerClass.playIndex
    };

    emitter.emit({ eventId: EmitEventType.UPDATE_STATE }, {
      data: {
        playState
      }
    });
  }
}