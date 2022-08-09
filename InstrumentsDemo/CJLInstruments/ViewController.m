//
//  ViewController.m
//  CJLInstruments
//
//  Created by CJL on 2022/8/3.
//

#import "ViewController.h"
#import "OSLog/OSLog.h"
#import "CJLInstruments-Swift.h""

@interface ViewController ()

@property (nonatomic, strong) UIButton *jsonDecodeBtn;
@property (nonatomic, strong) UIButton *imageDownloadBtn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    
}

- (void)setupUI{
    [self.view addSubview:self.jsonDecodeBtn];
    [self.view addSubview:self.imageDownloadBtn];
}

#pragma mark - 中级应用：模拟解析JSON字符串(自定义Instruments)

////模拟解析JSON字符串
- (void)jsonDecodeAction{
    //log句柄
    os_log_t parsingLog = os_log_create("com.cjl.json", "JSONDecode");
    // 创建os_signpost的ID
    os_signpost_id_t spid = os_signpost_id_generate(parsingLog);
    //开始
    os_signpost_interval_begin(parsingLog, spid, "Parsing", "Parsing started");
    //模拟JSON字符串解析
    NSInteger size = [self jsonDecode];
    //结束
    os_signpost_interval_end(parsingLog, spid, "Parsing", "Parsing finished SIZE:%ld", size);
}

//模拟事件
- (NSUInteger)jsonDecode{
    int timeOut = ( arc4random() % 6 ) / 4;
    sleep(timeOut);

    //模拟当前解析字符串的大小
    NSInteger size = arc4random() % 100 + 10;
    return size;
}

#pragma mark - 高级应用：模拟图片下载（自定义Instrument + 自定义建模器）
- (void)imageDownloadAction{
    ImageDownloadViewController *vc = [[ImageDownloadViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - Setter && Getter
- (UIButton *)jsonDecodeBtn{
    if (!_jsonDecodeBtn) {
        _jsonDecodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _jsonDecodeBtn.frame = CGRectMake(100, 100, 200, 50);
        _jsonDecodeBtn.backgroundColor = [UIColor lightGrayColor];
        [_jsonDecodeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_jsonDecodeBtn setTitle:@"模拟JSON解析" forState:UIControlStateNormal];
        [_jsonDecodeBtn addTarget:self action:@selector(jsonDecodeAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _jsonDecodeBtn;
}

- (UIButton *)imageDownloadBtn{
    if (!_imageDownloadBtn) {
        _imageDownloadBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _imageDownloadBtn.frame = CGRectMake(100, 300, 200, 50);
        _imageDownloadBtn.backgroundColor = [UIColor lightGrayColor];
        [_imageDownloadBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_imageDownloadBtn setTitle:@"模拟图片下载" forState:UIControlStateNormal];
        [_imageDownloadBtn addTarget:self action:@selector(imageDownloadAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _imageDownloadBtn;
}

@end
