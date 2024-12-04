import os
import re
from pathlib import Path
from cairosvg import svg2pdf
from PyPDF2 import PdfMerger

def natural_sort_key(path):
    """
    Create a key for natural sorting of filenames containing numbers.
    
    Args:
        path: Path object of the file
    
    Returns:
        tuple: (prefix, page_number) for sorting
    """
    filename = path.name
    match = re.search(r'page\s*(\d+)', filename, re.IGNORECASE)
    if match:
        page_num = int(match.group(1))
        prefix = filename[:match.start()]
        return (prefix, page_num)
    return (filename, 0)

def combine_svg_to_pdf(input_folder, output_file='combined_slides.pdf'):
    """
    Convert all SVG files in the input folder to a single PDF file,
    maintaining natural sort order and transparency.
    
    Args:
        input_folder (str): Path to the folder containing SVG files
        output_file (str): Path to the output PDF file
    
    Returns:
        tuple: (successful_conversions, failed_conversions)
    """
    successful_conversions = []
    failed_conversions = []
    
    # Get all SVG files in the input folder and sort them using natural sort
    svg_files = sorted(list(Path(input_folder).glob('*.svg')), key=natural_sort_key)
    total_files = len(svg_files)
    
    print(f"Found {total_files} SVG files to combine...")
    
    if total_files == 0:
        print("No SVG files found in the specified folder.")
        return [], []
    
    # Create a temporary folder for intermediate PDFs
    temp_folder = Path(input_folder) / '_temp_pdfs'
    temp_folder.mkdir(exist_ok=True)
    
    temp_pdfs = []
    
    # First convert each SVG to individual PDFs using CairoSVG
    for i, svg_path in enumerate(svg_files, 1):
        try:
            _, page_num = natural_sort_key(svg_path)
            temp_pdf_path = temp_folder / f"{page_num:04d}_{svg_path.stem}.pdf"
            
            # Convert SVG to PDF using CairoSVG
            with open(svg_path, 'rb') as svg_file:
                svg_content = svg_file.read()
                svg2pdf(bytestring=svg_content, write_to=str(temp_pdf_path))
            
            temp_pdfs.append(temp_pdf_path)
            successful_conversions.append(svg_path.name)
            print(f"[{i}/{total_files}] Successfully converted: {svg_path.name}")
            
        except Exception as e:
            failed_conversions.append((svg_path.name, str(e)))
            print(f"[{i}/{total_files}] Failed to convert {svg_path.name}: {str(e)}")
    
    if successful_conversions:
        try:
            # Combine all PDFs into one
            merger = PdfMerger()
            for pdf in sorted(temp_pdfs):
                merger.append(str(pdf))
            
            merger.write(output_file)
            merger.close()
            
            print(f"\nSuccessfully created combined PDF: {output_file}")
        except Exception as e:
            print(f"\nError while combining PDFs: {str(e)}")
    
    # Clean up temporary files
    for temp_pdf in temp_pdfs:
        try:
            temp_pdf.unlink()
        except:
            pass
    try:
        temp_folder.rmdir()
    except:
        pass
    
    # Print summary
    print("\nConversion Summary:")
    print(f"Successfully converted: {len(successful_conversions)} files")
    print(f"Failed conversions: {len(failed_conversions)} files")
    
    if failed_conversions:
        print("\nFailed conversions details:")
        for file, error in failed_conversions:
            print(f"- {file}: {error}")
    
    return successful_conversions, failed_conversions

if __name__ == "__main__":
    import argparse
    
    parser = argparse.ArgumentParser(description="Combine SVG files into a single PDF")
    parser.add_argument("input_folder", help="Folder containing SVG files")
    parser.add_argument("--output-file", default="combined_slides.pdf", 
                      help="Output PDF file (default: combined_slides.pdf)")
    
    args = parser.parse_args()
    
    combine_svg_to_pdf(args.input_folder, args.output_file)