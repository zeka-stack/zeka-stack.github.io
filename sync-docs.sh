#!/bin/bash

# 同步子模块 README.md 到 docs 目录的脚本
# 新的同步规则：
# 1. 从 root 目录开始遍历，如果存在 README.md，同步到 root/index.md
# 2. 只遍历到有 pom.xml 文件的目录层级，但如果有 pom.xml 的目录还有有 pom.xml 的子目录，继续递归
# 3. 如果有 pom.xml 且有 docs 目录（含 md 文件）→ 生成目录结构（index.md + docs 下的 md 文件）
# 4. 如果有 pom.xml 且无 docs 目录（或 docs 为空）且无有 pom.xml 的子目录 → 生成 flat 文件（目录名.md）在父目录
# 5. 如果有 pom.xml 且无 docs 目录但有有 pom.xml 的子目录 → 生成目录结构（index.md），继续递归子目录
# 只处理 arco-meta、blen-kernel、cubo-starter、cubo-starter-examples 这4个目录

# 不使用 set -e，以便更好地处理错误
set +e

# 颜色输出
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# 项目根目录（docs 的父目录）
ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
# docs 目录（当前脚本所在目录）
DOCS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# 要处理的顶级目录列表
TARGET_DIRS=("arco-meta" "blen-kernel" "cubo-starter" "cubo-starter-examples")

echo -e "${BLUE}========================================${NC}"
echo -e "${GREEN}Zeka Stack 文档同步工具${NC}"
echo -e "${BLUE}========================================${NC}"
echo ""

# 创建 docs 目录（如果不存在）
mkdir -p "${DOCS_DIR}"

# 统计变量
SYNCED_COUNT=0
IMGS_COUNT=0

# 函数：检查目录是否有 pom.xml
has_pom_xml() {
    local check_dir="$1"
    [[ -f "${check_dir}/pom.xml" ]]
}

# 函数：检查 docs 目录是否有 md 文件
has_docs_with_md() {
    local check_dir="$1"
    local docs_dir="${check_dir}/docs"

    if [[ ! -d "${docs_dir}" ]]; then
        return 1
    fi

    # 递归查找 docs 目录下的所有 md 文件
    local md_count
    md_count=$(find "${docs_dir}" -type f -name "*.md" 2>/dev/null | wc -l | tr -d ' ')
    [[ ${md_count} -gt 0 ]]
}

# 函数：检查目录是否有包含 pom.xml 的子目录
has_pom_subdirs() {
    local check_dir="$1"

    for subdir in "${check_dir}"/*; do
        [[ ! -d "${subdir}" ]] && continue
        local subdir_name
        subdir_name=$(basename "${subdir}")

        # 跳过特殊目录
        case "${subdir_name}" in
            docs|imgs|src|target|node_modules|.git|templates|.mvn|.idea|.vscode|assembly|bin|db|.*) continue ;;
        esac

        if has_pom_xml "${subdir}"; then
            return 0
        fi
    done
    return 1
}

# 函数：获取当前日期（格式：yyyy.mm.dd）
get_current_date() {
    date +"%Y.%m.%d"
}

# 函数：检查文件是否有 frontmatter
has_frontmatter() {
    local file="$1"
    # 检查文件是否以 --- 开头（frontmatter 开始标记）
    [[ -f "${file}" ]] && head -n 1 "${file}" 2>/dev/null | grep -q "^---$"
}

# 函数：为文件添加 frontmatter（如果不存在）
add_frontmatter_if_needed() {
    local file="$1"

    if ! has_frontmatter "${file}"; then
        local current_date
        current_date=$(get_current_date)
        local temp_file
        temp_file=$(mktemp)

        # 添加 frontmatter
        {
            echo "---"
            echo "published: ${current_date}"
            echo "---"
            echo ""
            cat "${file}"
        } > "${temp_file}"

        mv "${temp_file}" "${file}"
        echo -e "  ${BLUE}→${NC} 已添加 frontmatter (published: ${current_date})"
    fi
}

# 函数：检查文件是否已包含徽标
has_badges() {
    local file="$1"
    grep -q "Zeka%20Stack-core" "${file}" 2>/dev/null
}

# 函数：为文件添加徽标（如果不存在）
add_badges_if_needed() {
    local file="$1"

    if has_badges "${file}"; then
        return
    fi

    local badges_file
    badges_file=$(mktemp)
    cat <<'EOF' > "${badges_file}"
<p style="text-align:center; white-space:nowrap; overflow-x:auto; padding-bottom:4px;">
  <img src="https://img.shields.io/badge/Spring%20Boot-3.x-6DB33F?style=flat-square&amp;logo=spring" alt="Spring Boot 3.x" style="display:inline-block; vertical-align:middle;" />
  <img src="https://img.shields.io/badge/JDK-17%2B-007396?style=flat-square&amp;logo=java" alt="JDK17+" style="display:inline-block; vertical-align:middle;" />
  <img src="https://img.shields.io/badge/AI-enabled-FF6B6B?style=flat-square" alt="AI" style="display:inline-block; vertical-align:middle;" />
  <img src="https://img.shields.io/badge/%E6%9C%80%E4%BD%B3%E5%AE%9E%E8%B7%B5-guided-845EC2?style=flat-square" alt="最佳实践" style="display:inline-block; vertical-align:middle;" />
  <img src="https://img.shields.io/badge/%E6%B5%8B%E8%AF%95%E9%A9%B1%E5%8A%A8-TDD-1F7A8C?style=flat-square" alt="测试驱动" style="display:inline-block; vertical-align:middle;" />
  <img src="https://img.shields.io/badge/%E5%8D%95%E4%BD%93%E6%9E%B6%E6%9E%84-supported-5C7AEA?style=flat-square" alt="单体架构" style="display:inline-block; vertical-align:middle;" />
  <img src="https://img.shields.io/badge/%E5%BE%AE%E6%9C%8D%E5%8A%A1%E6%9E%B6%E6%9E%84-ready-1B9AAA?style=flat-square" alt="微服务架构" style="display:inline-block; vertical-align:middle;" />
</p>
EOF

    local temp_file
    temp_file=$(mktemp)

    if has_frontmatter "${file}"; then
        local fm_end_line
        fm_end_line=$(grep -n "^---$" "${file}" 2>/dev/null | sed -n '2p' | cut -d: -f1)
        if [[ -n "${fm_end_line}" ]]; then
            {
                sed -n "1,${fm_end_line}p" "${file}"
                echo ""
                cat "${badges_file}"
                echo ""
                sed -n "$((fm_end_line + 1)),\$p" "${file}"
            } > "${temp_file}"
        else
            {
                cat "${badges_file}"
                echo ""
                cat "${file}"
            } > "${temp_file}"
        fi
    else
        {
            cat "${badges_file}"
            echo ""
            cat "${file}"
        } > "${temp_file}"
    fi

    mv "${temp_file}" "${file}"
    rm -f "${badges_file}"
    echo -e "  ${BLUE}→${NC} 已添加徽标"
}

# 函数：同步 README.md 并添加代码链接
sync_readme() {
    local source_file="$1"
    local target_file="$2"
    local relative_path="$3"

    # 复制文件
    cp "${source_file}" "${target_file}"

    # 检查并添加 frontmatter（如果不存在）
    add_frontmatter_if_needed "${target_file}"
    # 检查并添加徽标（如果不存在）
    add_badges_if_needed "${target_file}"

    # 生成 GitHub 代码链接
    local github_url="https://github.com/dong4j/zeka.stack/tree/main/${relative_path}"

    # 检查文件末尾是否已经有代码链接标记
    if grep -q "<!-- 代码链接 -->" "${target_file}" 2>/dev/null; then
        # 删除从 "## 📦 代码示例" 到文件末尾的所有内容
        local temp_file
        temp_file=$(mktemp)
        sed '/^## 📦 代码示例$/,$d' "${target_file}" > "${temp_file}" 2>/dev/null
        mv "${temp_file}" "${target_file}"
    fi

    # 在文件末尾添加代码链接
    {
        echo ""
        echo "---"
        echo ""
        echo "## 📦 代码示例"
        echo ""
        echo "查看完整代码示例："
        echo ""
        echo "[${relative_path}](${github_url})"
        echo ""
        echo "<!-- 代码链接 -->"
    } >> "${target_file}"

    echo -e "  ${BLUE}→${NC} 已添加/更新代码链接"
}

# 函数：递归同步 docs 目录下的所有 md 文件到目标目录（保持子目录结构）
sync_docs_files() {
    local source_docs_dir="$1"
    local target_dir="$2"
    local relative_path="$3"

    if [[ ! -d "${source_docs_dir}" ]]; then
        return
    fi

    # 遍历 docs 目录下的所有内容
    while IFS= read -r -d '' doc_file; do
        # 计算相对于 source_docs_dir 的路径
        local rel_doc_path="${doc_file#${source_docs_dir}/}"
        local target_file="${target_dir}/${rel_doc_path}"
        local target_subdir
        target_subdir=$(dirname "${target_file}")

        # 创建目标子目录
        mkdir -p "${target_subdir}"

        # 复制文件
        cp "${doc_file}" "${target_file}"

        # 检查并添加 frontmatter（如果不存在）
        add_frontmatter_if_needed "${target_file}"
        # 检查并添加徽标（如果不存在）
        add_badges_if_needed "${target_file}"

        echo -e "  ${BLUE}→${NC} 已同步 docs/${rel_doc_path} -> docs/${relative_path}/${rel_doc_path}"
    done < <(find "${source_docs_dir}" -type f -name "*.md" -print0 2>/dev/null)
}

# 函数：同步 imgs 目录
sync_imgs_dir() {
    local source_dir="$1"
    local target_dir="$2"

    local imgs_dir="${source_dir}/imgs"
    local target_imgs_dir="${target_dir}/imgs"

    if [[ -d "${imgs_dir}" ]]; then
        if command -v rsync &> /dev/null; then
            rsync -aq --delete "${imgs_dir}/" "${target_imgs_dir}/"
        else
            if [[ -d "${target_imgs_dir}" ]]; then
                rm -rf "${target_imgs_dir}"
            fi
            cp -r "${imgs_dir}" "${target_dir}/"
        fi

        local img_count
        img_count=$(find "${imgs_dir}" -type f \( -iname "*.png" -o -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.gif" -o -iname "*.webp" -o -iname "*.svg" \) 2>/dev/null | wc -l | tr -d ' ')
        if [[ ${img_count} -gt 0 ]]; then
            echo -e "  ${BLUE}→${NC} 已同步 ${img_count} 个图片文件到 imgs/ 目录"
            ((IMGS_COUNT+=img_count))
        fi
    else
        if [[ -d "${target_imgs_dir}" ]]; then
            rm -rf "${target_imgs_dir}"
            echo -e "  ${YELLOW}→${NC} 已删除目标目录中的 imgs/ 目录（源目录中不存在）"
        fi
    fi
}

# 函数：处理有 pom.xml 的目录
# $1: 当前目录（有 pom.xml）
# $2: 父目录在 docs 中的目标路径
# 返回值：是否需要在父目录生成 flat 文件（0=需要目录结构，1=需要 flat 文件）
process_pom_dir() {
    local current_dir="$1"
    local parent_target_dir="$2"
    local relative_path="${current_dir#${ROOT_DIR}/}"
    local dir_name
    dir_name=$(basename "${current_dir}")
    local readme_file="${current_dir}/README.md"

    # 跳过 docs 目录本身和隐藏目录
    if [[ "${relative_path}" == "docs"* ]] || [[ "${relative_path}" == .* ]]; then
        return 1
    fi

    # 检查是否在目标目录下
    local is_target_dir=0
    for target_dir in "${TARGET_DIRS[@]}"; do
        if [[ "${relative_path}" == "${target_dir}"* ]]; then
            is_target_dir=1
            break
        fi
    done

    if [[ ${is_target_dir} -eq 0 ]]; then
        return 1
    fi

    # 必须有 README.md
    if [[ ! -f "${readme_file}" ]]; then
        return 1
    fi

    # 检查是否有 docs 目录且包含 md 文件，或者有有 pom.xml 的子目录
    local need_directory_structure=0

    if has_docs_with_md "${current_dir}"; then
        need_directory_structure=1
    elif has_pom_subdirs "${current_dir}"; then
        need_directory_structure=1
    fi

    if [[ ${need_directory_structure} -eq 1 ]]; then
        # 需要目录结构：生成 index.md
        local target_dir="${DOCS_DIR}/${relative_path}"
        mkdir -p "${target_dir}"
        local target_file="${target_dir}/index.md"

        # 同步 README.md 为 index.md
        sync_readme "${readme_file}" "${target_file}" "${relative_path}"
        echo -e "${GREEN}✓${NC} ${relative_path}/README.md -> docs/${relative_path}/index.md"
        ((SYNCED_COUNT++))

        # 同步 docs 目录下的文件（保持子目录结构）
        if has_docs_with_md "${current_dir}"; then
            sync_docs_files "${current_dir}/docs" "${target_dir}" "${relative_path}"
        fi

        # 同步 imgs 目录
        sync_imgs_dir "${current_dir}" "${target_dir}"

        # 继续处理有 pom.xml 的子目录
        process_pom_subdirs "${current_dir}" "${target_dir}"

        return 0
    else
        # 无 docs 目录且无有 pom.xml 的子目录：生成 flat 文件（目录名.md）在父目录
        local target_file="${parent_target_dir}/${dir_name}.md"
        mkdir -p "${parent_target_dir}"

        # 同步 README.md 为 目录名.md
        sync_readme "${readme_file}" "${target_file}" "${relative_path}"
        echo -e "${GREEN}✓${NC} ${relative_path}/README.md -> docs/${parent_target_dir#${DOCS_DIR}/}/${dir_name}.md"
        ((SYNCED_COUNT++))

        return 1
    fi
}

# 函数：处理目录下所有有 pom.xml 的子目录
process_pom_subdirs() {
    local current_dir="$1"
    local current_target_dir="$2"

    for subdir in "${current_dir}"/*; do
        [[ ! -d "${subdir}" ]] && continue
        local subdir_name
        subdir_name=$(basename "${subdir}")

        # 跳过特殊目录
        case "${subdir_name}" in
            docs|imgs|src|target|node_modules|.git|templates|.mvn|.idea|.vscode|assembly|bin|db|.*) continue ;;
        esac

        if has_pom_xml "${subdir}"; then
            process_pom_dir "${subdir}" "${current_target_dir}"
        fi
    done
}

# 函数：递归查找并处理所有有 pom.xml 的目录
# $1: 当前目录
# $2: 父目录在 docs 中的目标路径（用于 flat 文件）
find_pom_dirs() {
    local current_dir="$1"
    local parent_target_dir="${2:-${DOCS_DIR}}"

    if [[ ! -d "${current_dir}" ]]; then
        return
    fi

    # 计算当前目录在 docs 中的目标路径
    local current_relative_path="${current_dir#${ROOT_DIR}/}"
    local current_target_dir="${DOCS_DIR}/${current_relative_path}"

    # 先收集所有直接子目录
    for item in "${current_dir}"/*; do
        [[ ! -e "${item}" ]] && continue

        if [[ -d "${item}" ]]; then
            local dir_name
            dir_name=$(basename "${item}")

            # 跳过隐藏目录和特殊目录
            case "${dir_name}" in
                docs|imgs|src|target|node_modules|.git|templates|.mvn|.idea|.vscode|assembly|bin|db|guide|.*) continue ;;
            esac

            if has_pom_xml "${item}"; then
                # 处理有 pom.xml 的子目录
                process_pom_dir "${item}" "${current_target_dir}"
            fi
        fi
    done
}

# 函数：检查目录/文件是否来自源 docs 目录
# $1: docs 中的相对路径
# $2: 检查类型 "dir" 或 "file"
is_from_source_docs() {
    local relative_path="$1"
    local check_type="${2:-dir}"

    # 查找此路径对应的源模块路径
    # 例如：cubo-starter-examples/cubo-logsystem-spring-boot-sample/1.8.0
    # 需要检查源目录 cubo-starter-examples/cubo-logsystem-spring-boot-sample/docs/1.8.0 是否存在

    # 逐级向上查找，直到找到有 pom.xml 的目录
    local check_path="${relative_path}"
    while [[ -n "${check_path}" ]] && [[ "${check_path}" != "." ]]; do
        local source_dir="${ROOT_DIR}/${check_path}"
        if [[ -d "${source_dir}" ]] && has_pom_xml "${source_dir}"; then
            # 找到了源模块目录
            local remaining_path="${relative_path#${check_path}/}"
            if [[ "${remaining_path}" != "${relative_path}" ]] && [[ -n "${remaining_path}" ]]; then
                # 检查是否在源 docs 目录中
                local source_docs_path="${source_dir}/docs/${remaining_path}"
                if [[ "${check_type}" == "dir" ]]; then
                    [[ -d "${source_docs_path}" ]] && return 0
                else
                    [[ -f "${source_docs_path}" ]] && return 0
                fi
            fi
            break
        fi
        # 向上一级
        local new_check_path="${check_path%/*}"
        [[ "${new_check_path}" == "${check_path}" ]] && break
        check_path="${new_check_path}"
    done

    return 1
}

# 函数：递归清理已不存在的模块
cleanup_submodules() {
    local docs_subdir="$1"
    local relative_path="$2"
    local deleted_count=0

    if [[ ! -d "${docs_subdir}" ]]; then
        echo "0"
        return
    fi

    for item in "${docs_subdir}"/*; do
        if [[ ! -e "${item}" ]]; then
            continue
        fi

        if [[ -d "${item}" ]]; then
            local dir_name
            dir_name=$(basename "${item}")

            # 跳过 imgs 目录
            if [[ "${dir_name}" == "imgs" ]]; then
                continue
            fi

            local sub_relative_path="${relative_path}/${dir_name}"
            local source_submodule="${ROOT_DIR}/${sub_relative_path}"

            # 检查是否是源模块目录
            if [[ -d "${source_submodule}" ]]; then
                # 递归检查更深层的子模块
                local sub_deleted
                sub_deleted=$(cleanup_submodules "${item}" "${sub_relative_path}")
                deleted_count=$((deleted_count + sub_deleted))
            else
                # 检查是否来自源 docs 目录
                if is_from_source_docs "${sub_relative_path}" "dir"; then
                    # 来自源 docs，递归检查（但不检查子模块）
                    :
                else
                    # 不存在的模块，删除
                    rm -rf "${item}"
                    echo -e "  ${RED}✗${NC} 已删除不存在的模块: ${sub_relative_path}"
                    ((deleted_count++))
                fi
            fi
        elif [[ -f "${item}" ]] && [[ "${item}" == *.md ]]; then
            local file_name
            file_name=$(basename "${item}")

            # 跳过 index.md（它对应目录，由目录清理逻辑处理）
            if [[ "${file_name}" == "index.md" ]]; then
                continue
            fi

            local file_relative_path="${relative_path}/${file_name}"

            # 检查是否是 flat 文件（目录名.md）
            local possible_dir_name="${file_name%.md}"
            local possible_source_dir="${ROOT_DIR}/${relative_path}/${possible_dir_name}"

            # 检查源目录是否存在且有 pom.xml 和 README.md，且不需要目录结构
            if [[ -d "${possible_source_dir}" ]] && \
               has_pom_xml "${possible_source_dir}" && \
               [[ -f "${possible_source_dir}/README.md" ]] && \
               ! has_docs_with_md "${possible_source_dir}" && \
               ! has_pom_subdirs "${possible_source_dir}"; then
                # 是合法的 flat 文件，保留
                :
            # 检查是否来自源 docs 目录
            elif is_from_source_docs "${file_relative_path}" "file"; then
                # 是合法的 docs 文件，保留
                :
            else
                # 检查是否是 docs 目录下的文件（旧逻辑作为备选）
                local parent_source_dir="${ROOT_DIR}/${relative_path}"
                if has_pom_xml "${parent_source_dir}" && \
                   has_docs_with_md "${parent_source_dir}"; then
                    # 检查源 docs 目录中是否有此文件（包括子目录）
                    if find "${parent_source_dir}/docs" -type f -name "${file_name}" 2>/dev/null | grep -q .; then
                        # 是合法的 docs 文件，保留
                        :
                    else
                        # 不是合法的文件，删除
                        rm -f "${item}"
                        echo -e "  ${RED}✗${NC} 已删除不存在的文档: ${file_relative_path}"
                        ((deleted_count++))
                    fi
                else
                    # 不是合法的文件，删除
                    rm -f "${item}"
                    echo -e "  ${RED}✗${NC} 已删除不存在的文档: ${file_relative_path}"
                    ((deleted_count++))
                fi
            fi
        fi
    done

    echo "${deleted_count}"
}

# 函数：清理 docs 目录中已不存在的模块
cleanup_orphaned_modules() {
    echo -e "${YELLOW}正在清理已删除的模块...${NC}"
    local total_deleted=0

    if [[ -d "${DOCS_DIR}" ]]; then
        for target_dir in "${TARGET_DIRS[@]}"; do
            local docs_target_dir="${DOCS_DIR}/${target_dir}"
            if [[ ! -d "${docs_target_dir}" ]]; then
                continue
            fi

            local deleted
            deleted=$(cleanup_submodules "${docs_target_dir}" "${target_dir}")
            total_deleted=$((total_deleted + deleted))
        done
    fi

    if [[ ${total_deleted} -gt 0 ]]; then
        echo -e "已清理: ${RED}${total_deleted}${NC} 个不存在的模块/文档"
    fi
}

# 开始处理
echo -e "${YELLOW}正在扫描模块目录...${NC}"
echo ""

# 处理每个目标目录
for target_dir in "${TARGET_DIRS[@]}"; do
    source_dir="${ROOT_DIR}/${target_dir}"
    if [[ ! -d "${source_dir}" ]]; then
        echo -e "${YELLOW}⚠${NC} 目录不存在: ${target_dir}"
        continue
    fi

    echo -e "${BLUE}处理目录: ${target_dir}${NC}"

    # 检查顶级目录是否有 README.md，如果有则同步为 index.md
    if [[ -f "${source_dir}/README.md" ]]; then
        target_file="${DOCS_DIR}/${target_dir}/index.md"
        mkdir -p "${DOCS_DIR}/${target_dir}"
        sync_readme "${source_dir}/README.md" "${target_file}" "${target_dir}"
        echo -e "${GREEN}✓${NC} ${target_dir}/README.md -> docs/${target_dir}/index.md"
        ((SYNCED_COUNT++))
    fi

    # 递归查找并处理所有有 pom.xml 的目录
    find_pom_dirs "${source_dir}" "${DOCS_DIR}/${target_dir}"
    echo ""
done

echo ""
cleanup_orphaned_modules

echo ""
echo -e "${BLUE}========================================${NC}"
echo -e "${GREEN}同步完成！${NC}"
echo -e "${BLUE}========================================${NC}"
echo -e "已同步: ${GREEN}${SYNCED_COUNT}${NC} 个模块"
if [[ ${IMGS_COUNT} -gt 0 ]]; then
    echo -e "已同步: ${GREEN}${IMGS_COUNT}${NC} 个图片文件"
fi
