#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Zeka.Stack 文档同步脚本
自动收集和同步各个模块的 README.md 文档到 docsify 文档项目中
"""

import os
import shutil
import re
from pathlib import Path
from typing import Dict, List, Tuple, Optional

class DocsSync:
    def __init__(self, root_path: str, docs_path: str):
        """
        初始化文档同步器
        
        Args:
            root_path: 项目根目录路径
            docs_path: docsify 文档目录路径
        """
        self.root_path = Path(root_path)
        self.docs_path = Path(docs_path)
        self.component_path = self.docs_path / "docs" / "component"
        
        # 定义模块映射规则
        self.module_mappings = {
            # blen 系列模块
            "blen-kernel": "component/blen/README.md",
            
            # cubo 系列模块
            "cubo-starter": "component/cubo/README.md",
            
            # domi 系列模块
            "domi-auth": "component/domi/domi-auth.md",
            "domi-channel": "component/domi/domi-channel.md",
            "domi-gateway": "component/domi/domi-gateway.md",
            "domi-gateway-lite": "component/domi/domi-gateway-lite.md",
            "domi-logcat": "component/domi/domi-logcat.md",
            "domi-uid": "component/domi/domi-uid.md",
            "domi-ums": "component/domi/domi-ums.md",
            
            # eiko 系列模块
            "eiko-apm": "component/eiko/eiko-apm.md",
            "eiko-jetcache": "component/eiko/eiko-jetcache.md",
            "eiko-nacos": "component/eiko/eiko-nacos.md",
            "eiko-schedule": "component/eiko/eiko-schedule.md",
            "eiko-sentinel": "component/eiko/eiko-sentinel.md",
            
            # felo 系列模块
            "felo-mall": "component/felo/felo-mall.md",
            "felo-pay": "component/felo/felo-pay.md",
        }
        
        # 子模块映射规则（父模块/子模块 -> 目标路径）
        self.submodule_mappings = {
            # arco-meta 子模块
            "arco-meta/arco-supreme": "component/arco/arco-supreme.md",
            "arco-meta/arco-builder": "component/arco/arco-builder.md",
            "arco-meta/arco-processor": "component/arco/arco-processor.md",
            "arco-meta/arco-maven-plugin": "component/arco/arco-maven-plugin/README.md",
            
            # arco-maven-plugin 子模块
            "arco-meta/arco-maven-plugin/arco-assist-maven-plugin": "component/arco/arco-maven-plugin/arco-assist-maven-plugin.md",
            "arco-meta/arco-maven-plugin/arco-boot-maven-plugin": "component/arco/arco-maven-plugin/arco-boot-maven-plugin.md",
            "arco-meta/arco-maven-plugin/arco-checkstyle-plugin-rule": "component/arco/arco-maven-plugin/arco-checkstyle-plugin-rule.md",
            "arco-meta/arco-maven-plugin/arco-container-maven-plugin": "component/arco/arco-maven-plugin/arco-container-maven-plugin.md",
            "arco-meta/arco-maven-plugin/arco-enforcer-plugin-rule": "component/arco/arco-maven-plugin/arco-enforcer-plugin-rule.md",
            "arco-meta/arco-maven-plugin/arco-makeself-maven-plugin": "component/arco/arco-maven-plugin/arco-makeself-maven-plugin.md",
            "arco-meta/arco-maven-plugin/arco-maven-plugin-common": "component/arco/arco-maven-plugin/arco-maven-plugin-common.md",
            "arco-meta/arco-maven-plugin/arco-pmd-plugin-rule": "component/arco/arco-maven-plugin/arco-pmd-plugin-rule.md",
            "arco-meta/arco-maven-plugin/arco-publish-maven-plugin": "component/arco/arco-maven-plugin/arco-publish-maven-plugin.md",
            "arco-meta/arco-maven-plugin/arco-script-maven-plugin": "component/arco/arco-maven-plugin/arco-script-maven-plugin.md",
            
            # blen-kernel 子模块
            "blen-kernel/blen-kernel-auth": "component/blen/blen-kernel-auth.md",
            "blen-kernel/blen-kernel-autoconfigure": "component/blen/blen-kernel-autoconfigure.md",
            "blen-kernel/blen-kernel-common": "component/blen/blen-kernel-common.md",
            "blen-kernel/blen-kernel-dependencies": "component/blen/blen-kernel-dependencies.md",
            "blen-kernel/blen-kernel-devtools": "component/blen/blen-kernel-devtools.md",
            "blen-kernel/blen-kernel-extend": "component/blen/blen-kernel-extend.md",
            "blen-kernel/blen-kernel-notify": "component/blen/blen-kernel-notify.md",
            "blen-kernel/blen-kernel-spi": "component/blen/blen-kernel-spi.md",
            "blen-kernel/blen-kernel-test": "component/blen/blen-kernel-test.md",
            "blen-kernel/blen-kernel-tracer": "component/blen/blen-kernel-tracer.md",
            "blen-kernel/blen-kernel-validation": "component/blen/blen-kernel-validation.md",
            "blen-kernel/blen-kernel-web": "component/blen/blen-kernel-web.md",
            
            # cubo-starter 子模块
            "cubo-starter/cubo-launcher-spring-boot": "component/cubo/cubo-launcher-spring-boot.md",
            "cubo-starter/cubo-dict-spring-boot": "component/cubo/cubo-dict-spring-boot.md",
            "cubo-starter/cubo-endpoint-spring-boot": "component/cubo/cubo-endpoint-spring-boot.md",
            "cubo-starter/cubo-logsystem-spring-boot": "component/cubo/cubo-logsystem-spring-boot.md",
            "cubo-starter/cubo-messaging-spring-boot": "component/cubo/cubo-messaging-spring-boot.md",
            "cubo-starter/cubo-mybatis-spring-boot": "component/cubo/cubo-mybatis-spring-boot.md",
            "cubo-starter/cubo-openapi-spring-boot": "component/cubo/cubo-openapi-spring-boot.md",
            "cubo-starter/cubo-rest-spring-boot": "component/cubo/cubo-rest-spring-boot.md",
        }

    def find_readme_files(self) -> List[Tuple[Path, str]]:
        """
        查找所有需要同步的 README.md 文件
        
        Returns:
            List[Tuple[Path, str]]: (文件路径, 相对路径) 的列表
        """
        readme_files = []
        
        # 查找根目录下的主要模块
        for item in self.root_path.iterdir():
            if item.is_dir() and not item.name.startswith('.'):
                readme_file = item / "README.md"
                if readme_file.exists():
                    relative_path = item.name
                    readme_files.append((readme_file, relative_path))
                
                # 查找子模块（支持多层级）
                self._find_submodule_readmes(item, item.name, readme_files)
        
        return readme_files
    
    def _find_submodule_readmes(self, parent_dir: Path, parent_path: str, readme_files: List[Tuple[Path, str]]):
        """
        递归查找子模块的 README.md 文件
        
        Args:
            parent_dir: 父目录路径
            parent_path: 父目录的相对路径
            readme_files: README 文件列表
        """
        for sub_item in parent_dir.iterdir():
            if sub_item.is_dir() and not sub_item.name.startswith('.'):
                sub_relative_path = f"{parent_path}/{sub_item.name}"
                
                sub_readme = sub_item / "README.md"
                if sub_readme.exists():
                    readme_files.append((sub_readme, sub_relative_path))
                
                # 递归查找更深层级的子模块
                self._find_submodule_readmes(sub_item, sub_relative_path, readme_files)

    def get_target_path(self, relative_path: str) -> Optional[Path]:
        """
        根据相对路径获取目标文件路径
        
        Args:
            relative_path: 源文件的相对路径
            
        Returns:
            Optional[Path]: 目标文件路径，如果不需要同步则返回 None
        """
        # 检查子模块映射
        if relative_path in self.submodule_mappings:
            target_relative = self.submodule_mappings[relative_path]
            return self.docs_path / "docs" / target_relative
        
        # 检查主模块映射
        if relative_path in self.module_mappings:
            target_relative = self.module_mappings[relative_path]
            return self.docs_path / "docs" / target_relative
        
        return None

    def sync_file(self, source_path: Path, target_path: Path) -> bool:
        """
        同步单个文件
        
        Args:
            source_path: 源文件路径
            target_path: 目标文件路径
            
        Returns:
            bool: 是否成功同步
        """
        try:
            # 确保目标目录存在
            target_path.parent.mkdir(parents=True, exist_ok=True)
            
            # 复制文件
            shutil.copy2(source_path, target_path)
            print(f"✅ 已同步: {source_path} -> {target_path}")
            return True
        except Exception as e:
            print(f"❌ 同步失败: {source_path} -> {target_path}, 错误: {e}")
            return False

    def update_sidebar(self, synced_files: List[Tuple[Path, str]]) -> bool:
        """
        更新 _sidebar.md 文件
        
        Args:
            synced_files: 已同步的文件列表
            
        Returns:
            bool: 是否成功更新
        """
        try:
            sidebar_path = self.component_path / "_sidebar.md"
            
            # 读取现有内容
            if sidebar_path.exists():
                with open(sidebar_path, 'r', encoding='utf-8') as f:
                    content = f.read()
            else:
                content = ""
            
            # 根据已同步的文件生成新的侧边栏内容
            new_content = self.generate_sidebar_from_synced_files(synced_files)
            
            # 如果内容有变化，则更新文件
            if content != new_content:
                with open(sidebar_path, 'w', encoding='utf-8') as f:
                    f.write(new_content)
                print("✅ 已更新 _sidebar.md")
                return True
            else:
                print("ℹ️  _sidebar.md 无需更新")
                return True
                
        except Exception as e:
            print(f"❌ 更新 _sidebar.md 失败: {e}")
            return False

    def generate_sidebar_from_synced_files(self, synced_files: List[Tuple[Path, str]]) -> str:
        """
        根据已同步的文件生成侧边栏内容
        
        Args:
            synced_files: 已同步的文件列表
            
        Returns:
            str: 侧边栏内容
        """
        # 按模块分类组织文件
        modules = {
            'arco': {'main': [], 'maven-plugin': []},
            'blen': {'main': [], 'submodules': []},
            'cubo': {'main': [], 'submodules': []},
            'domi': {'main': [], 'submodules': []},
            'eiko': {'main': [], 'submodules': []},
            'felo': {'main': [], 'submodules': []}
        }
        
        # 分析已同步的文件
        for source_path, target_path in synced_files:
            # target_path 是相对于 docs 目录的路径，如 "docs/component/blen/README.md"
            parts = target_path.split('/')
            
            if len(parts) >= 4 and parts[0] == 'docs' and parts[1] == 'component':
                module_type = parts[2]
                if module_type in modules:
                    if len(parts) == 4:
                        # 主模块文件或子模块文件
                        if parts[3] == 'README.md':
                            modules[module_type]['main'].append('README')
                        else:
                            # 检查是否是子模块文件
                            if module_type in ['blen', 'cubo']:
                                modules[module_type]['submodules'].append(parts[3].replace('.md', ''))
                            else:
                                modules[module_type]['main'].append(parts[3].replace('.md', ''))
                    elif len(parts) == 5:
                        # arco-maven-plugin 子模块文件
                        if parts[3] == 'arco-maven-plugin':
                            modules[module_type]['maven-plugin'].append(parts[4].replace('.md', ''))
                        else:
                            modules[module_type]['submodules'].append(parts[4].replace('.md', ''))
        
        lines = []
        
        # 生成 arco 系列
        if modules['arco']['main'] or modules['arco']['maven-plugin']:
            lines.append("* [项目管理](component/arco/)")
            
            # arco 主模块
            for module in sorted(modules['arco']['main']):
                if module != 'README':
                    lines.append(f"    * [{module}](component/arco/{module})")
            
            # arco-maven-plugin
            if modules['arco']['maven-plugin']:
                lines.append("    * [arco-maven-plugin](component/arco/arco-maven-plugin/)")
                for module in sorted(modules['arco']['maven-plugin']):
                    if module != 'README':
                        lines.append(f"        * [{module}](component/arco/arco-maven-plugin/{module})")
        
        # 生成 blen 系列
        if modules['blen']['main'] or modules['blen']['submodules']:
            lines.append("* [核心层](component/blen/)")
            for module in sorted(modules['blen']['submodules']):
                lines.append(f"    * [{module}](component/blen/{module})")
        
        # 生成 cubo 系列
        if modules['cubo']['main'] or modules['cubo']['submodules']:
            lines.append("* [Starter](component/cubo/)")
            for module in sorted(modules['cubo']['submodules']):
                lines.append(f"    * [{module}](component/cubo/{module})")
        
        # 生成 domi 系列
        if modules['domi']['submodules']:
            lines.append("* [Domi 套件](component/domi/)")
            for module in sorted(modules['domi']['submodules']):
                lines.append(f"    * [{module}](component/domi/{module})")
        
        # 生成 eiko 系列
        if modules['eiko']['submodules']:
            lines.append("* [Eiko 编排](component/eiko/)")
            for module in sorted(modules['eiko']['submodules']):
                lines.append(f"    * [{module}](component/eiko/{module})")
        
        # 生成 felo 系列
        if modules['felo']['submodules']:
            lines.append("* [Felo 空间](component/felo/)")
            for module in sorted(modules['felo']['submodules']):
                lines.append(f"    * [{module}](component/felo/{module})")
        
        lines.append("* [示例项目](component/examples)")
        
        return "\n".join(lines)

    def sync_all(self) -> bool:
        """
        同步所有文档
        
        Returns:
            bool: 是否全部成功
        """
        print("🚀 开始同步文档...")
        
        # 查找所有 README 文件
        readme_files = self.find_readme_files()
        print(f"📁 找到 {len(readme_files)} 个 README 文件")
        
        success_count = 0
        total_count = 0
        synced_files = []  # 记录已同步的文件
        
        # 同步文件
        for source_path, relative_path in readme_files:
            target_path = self.get_target_path(relative_path)
            
            if target_path is None:
                print(f"⏭️  跳过: {relative_path} (未配置映射规则)")
                continue
            
            total_count += 1
            if self.sync_file(source_path, target_path):
                success_count += 1
                # 记录已同步的文件
                synced_files.append((source_path, str(target_path.relative_to(self.docs_path))))
        
        # 更新侧边栏
        if self.update_sidebar(synced_files):
            success_count += 1
        total_count += 1
        
        print(f"\n📊 同步完成: {success_count}/{total_count} 成功")
        return success_count == total_count

def main():
    """主函数"""
    # 获取脚本所在目录作为文档目录
    script_dir = Path(__file__).parent
    docs_path = script_dir
    root_path = script_dir.parent  # 项目根目录是文档目录的父目录
    
    print(f"📂 项目根目录: {root_path}")
    print(f"📂 文档目录: {docs_path}")
    
    # 检查目录是否存在
    if not root_path.exists():
        print(f"❌ 项目根目录不存在: {root_path}")
        return 1
    
    # 创建同步器并执行同步
    syncer = DocsSync(str(root_path), str(docs_path))
    
    if syncer.sync_all():
        print("🎉 文档同步完成！")
        return 0
    else:
        print("⚠️  文档同步部分失败，请检查错误信息")
        return 1

if __name__ == "__main__":
    exit(main())
