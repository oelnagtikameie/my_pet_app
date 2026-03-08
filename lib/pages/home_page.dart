import 'package:flutter/material.dart';
import 'package:flutter_unity_widget/flutter_unity_widget.dart';
import 'records.dart';     // 记录页
import 'dress_up.dart';    // 装扮页
import 'chat_page.dart';   // 聊天页
import 'tree_hole.dart';   // 树洞页

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  UnityWidgetController? _unityWidgetController;
  final int _heartCount = 105; // 模拟从数据库或Unity获取的数据

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 1. 底层：Unity 场景
          UnityWidget(
            onUnityCreated: (controller) => _unityWidgetController = controller,
            onUnityMessage: (message) {
              // 处理从 Unity 传来的消息（如点击了小动物）
              print("Unity Message: $message");
            },
          ),

          // 2. 上层：Flutter UI 按钮
          _buildTopUI(),
          _buildSideButtons(),
        ],
      ),
    );
  }

  // 左上角血条/状态
  Widget _buildTopUI() {
    return Positioned(
      top: 50, left: 20,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(color: Colors.white70, border: Border.all(width: 2)),
        child: Row(
          children: [
            Text('$_heartCount ❤️', style: const TextStyle(fontWeight: FontWeight.bold)),
            const Icon(Icons.add_circle, size: 20, color: Colors.orange),
          ],
        ),
      ),
    );
  }

  // 四个角落和侧边的方形按钮
  // 修改后的按钮区域
  Widget _buildSideButtons() {
    return Stack(
      children: [
        // 右上角：装扮、记录
        Positioned(
          top: 50, right: 20,
          child: Column(
            children: [
              _squareButton("装扮", "assets/images/dress_up_btn.png", () {
                Navigator.push(context, MaterialPageRoute(builder: (c) => const DressUpPage()));
              }), 
              const SizedBox(height: 10),
              _squareButton("记录", "assets/images/record_btn.png", () {
                Navigator.push(context, MaterialPageRoute(builder: (c) => const RecordsPage()));
              }),
            ],
          ),
        ),
        
        // 左下角：个性化、聊天
        Positioned(
          bottom: 100, left: 20,
          child: Column(
            children: [
              _squareButton("个性化", "assets/images/personal_btn.png", () {
                // 这里暂时跳到 RecordsPage 或其他你准备好的页面
              }),
              const SizedBox(height: 10),
              _squareButton("聊天", "assets/images/chat_btn.png", () {
                Navigator.push(context, MaterialPageRoute(builder: (c) => const ChatPage()));
              }),
            ],
          ),
        ),

        // 右下角：树洞、小游戏
        Positioned(
          bottom: 100, right: 20,
          child: Column(
            children: [
              _squareButton("树洞", "assets/images/tree_hole_btn.png", () {
                Navigator.push(context, MaterialPageRoute(builder: (c) => const TreeHolePage()));
              }),
              const SizedBox(height: 10),
              _squareButton("小游戏", "assets/images/game_btn.png", () {
                 _showGameDialog(); // 弹出选择跑酷或探索的对话框
              }),
            ],
          ),
        ),
      ],
    );
  }

void _showGameDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("选择游戏模式"),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _squareButton("跑酷", "assets/images/game_btn.png", () {
              _unityWidgetController?.postMessage("SceneManager", "LoadScene", "Parkour");
              Navigator.pop(context);
            }),
            _squareButton("探索", "assets/images/game_btn.png", () {
              _unityWidgetController?.postMessage("SceneManager", "LoadScene", "Explore");
              Navigator.pop(context);
            }),
          ],
        ),
      ),
    );
  }

  // 通用的方形图片按钮模板
  // 优化后的方形图片按钮模板：现在第二个参数接受 imagePath (String)
// 唯一的、正确的方形图片按钮模板
  Widget _squareButton(String label, String imagePath, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 75, height: 75,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.8), 
          border: Border.all(color: Colors.brown, width: 2),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  imagePath, 
                  fit: BoxFit.contain,
                  // 这里的 errorBuilder 非常重要，能防止图片路径写错时程序崩溃
                  errorBuilder: (context, error, stackTrace) => const Icon(Icons.broken_image),
                ),
              ),
            ),
            Text(label, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.brown)),
          ],
        ),
      ),
    );
  }
}