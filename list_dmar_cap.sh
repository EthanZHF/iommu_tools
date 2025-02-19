#!/bin/bash

# Function to decode CAP register
decode_cap() {
    local cap=$1

    printf "%-60s: %-10d Bits: %-5s Binary: %s\n" "Enhanced Set Root Table Pointer Support (ESRTPS)" $(( (cap >> 63) & 1 )) "63" "$(printf '%01b' $(( (cap >> 63) & 1 )))"
    printf "%-60s: %-10d Bits: %-5s Binary: %s\n" "Enhanced Set Interrupt Remap Table Pointer Support (ESIRTPS)" $(( (cap >> 62) & 1 )) "62" "$(printf '%01b' $(( (cap >> 62) & 1 )))"
    printf "%-60s: %-10d Bits: %-5s Binary: %s\n" "Enhanced Command Support (ECMDS)" $(( (cap >> 61) & 1 )) "61" "$(printf '%01b' $(( (cap >> 61) & 1 )))"
    printf "%-60s: %-10d Bits: %-5s Binary: %s\n" "First Stage 5-level Paging Support (FS5LP)" $(( (cap >> 60) & 1 )) "60" "$(printf '%01b' $(( (cap >> 60) & 1 )))"
    printf "%-60s: %-10d Bits: %-5s Binary: %s\n" "Posted Interrupts Support (PI)" $(( (cap >> 59) & 1 )) "59" "$(printf '%01b' $(( (cap >> 59) & 1 )))"
    printf "%-60s: %-10d Bits: %-5s Binary: %s\n" "Reserved (RsvdZ)" $(( (cap >> 58) & 1 )) "58" "$(printf '%01b' $(( (cap >> 58) & 1 )))"
    printf "%-60s: %-10d Bits: %-5s Binary: %s\n" "Reserved (RsvdZ)" $(( (cap >> 57) & 1 )) "57" "$(printf '%01b' $(( (cap >> 57) & 1 )))"
    printf "%-60s: %-10d Bits: %-5s Binary: %s\n" "First Stage 1-GByte Page Support (FS1GP)" $(( (cap >> 56) & 1 )) "56" "$(printf '%01b' $(( (cap >> 56) & 1 )))"


    printf "%-60s: %-10d Bits: %-5s Binary: %s\n" "Read Draining (DRD)" $(( (cap >> 55) & 1 )) "55" "$(printf '%01b' $(( (cap >> 55) & 1 )))"
    printf "%-60s: %-10d Bits: %-5s Binary: %s\n" "Write Draining (DWD)" $(( (cap >> 54) & 1 )) "54" "$(printf '%01b' $(( (cap >> 54) & 1 )))"
    printf "%-60s: %-10d Bits: %-5s Hex   : %s\n" "Maximum Address Mask Value (MAMV)" $(( (cap >> 48) & 0x3F )) "53:48" "$(printf '%04xh' $(( (cap >> 48) & 0x3F )))"
    printf "%-60s: %-10d Bits: %-5s Hex   : %s\n" "Number of Fault-recording Registers (NFR)" $(( (cap >> 40) & 0xFF )) "47:40" "$(printf '%04xh' $(( (cap >> 40) & 0xFF )))"
    printf "%-60s: %-10d Bits: %-5s Binary: %s\n" "Page Selective Invalidation (PSI)" $(( (cap >> 39) & 1 )) "39" "$(printf '%01b' $(( (cap >> 39) & 1 )))"

    printf "%-60s: %-10d Bits: %-5s Binary: %s\n" "Second Stage Large Page Support (SSLPS)" $(( (cap >> 34) & 0xF )) "37:34" "$(printf '%02xh' $(( (cap >> 34) & 0xF )))"
    printf "%-60s: %-10d Bits: %-5s Binary: %s\n" "Fault-recording Register Offset (FRO)" $(( (cap >> 24) & 0x3FF )) "33:24" "$(printf '%02xh' $(( (cap >> 24) & 0x3FF )))"
    printf "%-60s: %-10d Bits: %-5s Binary: %s\n" "Deprecated (DEP)" $(( (cap >> 23) & 1 )) "23" "$(printf '%01b' $(( (cap >> 23) & 1 )))"
    printf "%-60s: %-10d Bits: %-5s Binary: %s\n" "Zero Length Read (ZLR)" $(( (cap >> 22) & 1 )) "22" "$(printf '%01b' $(( (cap >> 22) & 1 )))"
    printf "%-60s: %-10d Bits: %-5s Binary: %s\n" "Maximum Guest Address Width (MGAW)" $(( (cap >> 16) & 0x3F )) "21:16" "$(printf '%02xh' $(( (cap >> 16) & 0x3F )))"

    printf "%-60s: %-10d Bits: %-5s Hex   : %s\n" "Supported Adjusted Guest Address Widths (SAGAW)" $(( (cap >> 8) & 0x1F )) "12:8" "$(printf '%02xh' $(( (cap >> 8) & 0x1F )))"
    printf "%-60s: %-10d Bits: %-5s Binary: %s\n" "Caching Mode (CM)" $(( (cap >> 7) & 1 )) "7" "$(printf '%01b' $(( (cap >> 7) & 1 )))"
    printf "%-60s: %-10d Bits: %-5s Binary: %s\n" "Protected High-Memory Region (PHMR)" $(( (cap >> 6) & 1 )) "6" "$(printf '%01b' $(( (cap >> 6) & 1 )))"
    printf "%-60s: %-10d Bits: %-5s Binary: %s\n" "Protected Low-Memory Region (PLMR)" $(( (cap >> 5) & 1 )) "5" "$(printf '%01b' $(( (cap >> 5) & 1 )))"
    printf "%-60s: %-10d Bits: %-5s Binary: %s\n" "Required Write-Buffer Flushing (RWBF)" $(( (cap >> 4) & 1 )) "4" "$(printf '%01b' $(( (cap >> 4) & 1 )))"
    nd_value=$(( (cap >> 0) & 0x7 ))  # 提取 bit 2:0   
    case $nd_value in
    	0) nd_desc="4-bit domain-ids (16 domains)";;
    	1) nd_desc="6-bit domain-ids (64 domains)";;
    	2) nd_desc="8-bit domain-ids (256 domains)";;
    	3) nd_desc="10-bit domain-ids (1024 domains)";;
    	4) nd_desc="12-bit domain-ids (4K domains)";;
    	5) nd_desc="14-bit domain-ids (16K domains)";;
    	6) nd_desc="16-bit domain-ids (64K domains)";;
    	7) nd_desc="Reserved";;
    esac
    printf "%-60s: %-10d Bits: %-5s Binary: %s (%s)\n" "Number of Domains Supported (ND)" $nd_value "2:0" "$(printf '%02xh' $nd_value)" "$nd_desc"

}

# Function to decode ECAP register
decode_ecap() {
    local ecap=$1
    printf "%-50s: %-10d Bits: %-5s Binary: %s\n" "Page-walk Coherency (PWC)" $(( ecap & 1 )) "0" "$(printf '%01b' $(( ecap & 1 )))"
    printf "%-50s: %-10d Bits: %-5s Binary: %s\n" "Queued Invalidation Support (QI)" $(( (ecap >> 1) & 1 )) "1" "$(printf '%01b' $(( (ecap >> 1) & 1 )))"
    printf "%-50s: %-10d Bits: %-5s Binary: %s\n" "Device-TLB Support (DTLBS)" $(( (ecap >> 2) & 1 )) "2" "$(printf '%01b' $(( (ecap >> 2) & 1 )))"
    printf "%-50s: %-10d Bits: %-5s Binary: %s\n" "Interrupt Remapping Support (IR)" $(( (ecap >> 3) & 1 )) "3" "$(printf '%01b' $(( (ecap >> 3) & 1 )))"
    printf "%-50s: %-10d Bits: %-5s Binary: %s\n" "Extended Interrupt Mode (EIM)" $(( (ecap >> 4) & 1 )) "4" "$(printf '%01b' $(( (ecap >> 4) & 1 )))"
    printf "%-50s: %-10d Bits: %-5s Binary: %s\n" "Deprecated (DEP)" $(( (ecap >> 6) & 1 )) "6" "$(printf '%01b' $(( (ecap >> 6) & 1 )))"
    printf "%-50s: %-10d Bits: %-5s Binary: %s\n" "Pass-through Support (PTS)" $(( (ecap >> 6) & 1 )) "6" "$(printf '%01b' $(( (ecap >> 6) & 1 )))"
    printf "%-50s: %-10d Bits: %-5s Binary: %s\n" "Snoop Control (SC)" $(( (ecap >> 7) & 1 )) "7" "$(printf '%01b' $(( (ecap >> 7) & 1 )))"
    printf "%-50s: %-10d Bits: %-5s Hex   : %s\n" "IOTLB Register Offset (IRO)" $(( (ecap >> 8) & 0x3ff )) "8-17" "$(printf '%03xh' $(( (ecap >> 8) & 0x3ff )))"
    printf "%-50s: %-10d Bits: %-5s Hex   : %s\n" "Maximum Handle Mask Value (MHMV)" $(( (ecap >> 20) & 0xf )) "20-23" "$(printf '%03xh' $(( (ecap >> 20) & 0xf )))"
    printf "%-50s: %-10d Bits: %-5s Binary: %s\n" "Memory Type Support (MTS)" $(( (ecap >> 25) & 1 )) "25" "$(printf '%01b' $(( (ecap >> 25) & 1 )))"
    printf "%-50s: %-10d Bits: %-5s Binary: %s\n" "Nested Translation Support (NTS)" $(( (ecap >> 26) & 1 )) "26" "$(printf '%01b' $(( (ecap >> 26) & 1 )))"
    printf "%-50s: %-10d Bits: %-5s Binary: %s\n" "Page Request Support (PRS)" $(( (ecap >> 29) & 1 )) "29" "$(printf '%01b' $(( (ecap >> 29) & 1 )))"
    printf "%-50s: %-10d Bits: %-5s Binary: %s\n" "Execute Request Support (ERS)" $(( (ecap >> 30) & 1 )) "30" "$(printf '%01b' $(( (ecap >> 30) & 1 )))" 
    printf "%-50s: %-10d Bits: %-5s Binary: %s\n" "Supervisor Request Support (SRS)" $(( (ecap >> 31) & 1 )) "31" "$(printf '%01b' $(( (ecap >> 31) & 1 )))"
    printf "%-50s: %-10d Bits: %-5s Binary: %s\n" "No Write Flag Support (NWFS)" $(( (ecap >> 33) & 1 )) "33" "$(printf '%01b' $(( (ecap >> 33) & 1 )))"
    printf "%-50s: %-10d Bits: %-5s Binary: %s\n" "Extended Accessed Flag Support (EAFS)" $(( (ecap >> 34) & 1 )) "34" "$(printf '%01b' $(( (ecap >> 34) & 1 )))"
    printf "%-50s: %-10d Bits: %-5s Hex   : %s\n" "PASID Size Support (PSS)" $(( (ecap >> 35) & 0x1f )) "35-39" "$(printf '%03xh' $(( (ecap >> 35) & 0x1f )))"
    printf "%-50s: %-10d Bits: %-5s Binary: %s\n" "Process Address Space ID support (PASID)" $(( (ecap >> 40) & 1)) "40" "$(printf '%01b' $(( (ecap >> 40) & 1)))"
    printf "%-50s: %-10d Bits: %-5s Binary: %s\n" "Deivce-TLB Invalidation Throttle (DIT)" $(( (ecap >> 41) & 1)) "41" "$(printf '%01b' $(( (ecap >> 41) & 1)))"
    printf "%-50s: %-10d Bits: %-5s Binary: %s\n" "Page-request Drain Support (PDS)" $(( (ecap >> 42) & 1 )) "42" "$(printf '%01b' $(( (ecap >> 42) & 1 )))"
    printf "%-50s: %-10d Bits: %-5s Binary: %s\n" "Scalable Mode Translation Support (SMTS)" $(( (ecap >> 43) & 1 )) "43" "$(printf '%01b' $(( (ecap >> 43) & 1 )))"
    printf "%-50s: %-10d Bits: %-5s Binary: %s\n" "Virtual Command Support (VCS)" $(( (ecap >> 44) & 1 )) "44" "$(printf '%01b' $(( (ecap >> 44) & 1 )))"
    printf "%-50s: %-10d Bits: %-5s Binary: %s\n" "Second-Stage Accessed/Dirty Support (SSADS)" $(( (ecap >> 45) & 1 )) "45" "$(printf '%01b' $(( (ecap >> 45) & 1 )))"
    printf "%-50s: %-10d Bits: %-5s Binary: %s\n" "Second-Stage Translation Support (SSTS)" $(( (ecap >> 46) & 1 )) "46" "$(printf '%01b' $(( (ecap >> 46) & 1 )))"
    printf "%-50s: %-10d Bits: %-5s Binary: %s\n" "First-Stage Translation Support (FSTS)" $(( (ecap >> 47) & 1 )) "47" "$(printf '%01b' $(( (ecap >> 47) & 1 )))"
    printf "%-50s: %-10d Bits: %-5s Binary: %s\n" "Scalable-Mode Page-walk Coherency Support (SMPWCS)" $(( (ecap >> 48) & 1 )) "48" "$(printf '%01b' $(( (ecap >> 48) & 1 )))"
    printf "%-50s: %-10d Bits: %-5s Binary: %s\n" "RID-PASID Support (RPS)" $(( (ecap >> 49) & 1 )) "49" "$(printf '%01b' $(( (ecap >> 49) & 1 )))"    
    printf "%-50s: %-10d Bits: %-5s Binary: %s\n" "Performance Monitoring Support (PMS)" $(( (ecap >> 51) & 1 )) "51" "$(printf '%01b' $(( (ecap >> 51) & 1 )))"
    printf "%-50s: %-10d Bits: %-5s Binary: %s\n" "Abort DMA Mode Support (ADMS)" $(( (ecap >> 52) & 1 )) "52" "$(printf '%01b' $(( (ecap >> 52) & 1 )))"
    printf "%-50s: %-10d Bits: %-5s Binary: %s\n" "RID_PRIV SUPPORT (RPRIVS)" $(( (ecap >> 53) & 1 )) "53" "$(printf '%01b' $(( (ecap >> 53) & 1 )))"
    printf "%-50s: %-10d Bits: %-5s Binary: %s\n" "HPT SUPPORT (HPTS)" $(( (ecap >> 55) & 1 )) "55" "$(printf '%01b' $(( (ecap >> 55) & 1 )))"
    printf "%-50s: %-10d Bits: %-5s Binary: %s\n" "PASID in Translated Request Support (PTRS)" $(( (ecap >> 56) & 1 )) "56" "$(printf '%01b' $(( (ecap >> 56) & 1 )))"
    printf "%-50s: %-10d Bits: %-5s Binary: %s\n" "Second Stage I/O Read/Write Support (SSIRWS)" $(( (ecap >> 57) & 1 )) "57" "$(printf '%01b' $(( (ecap >> 57) & 1 )))"
    printf "%-50s: %-10d Bits: %-5s Binary: %s\n" "Stop Marker Support (SMS)" $(( (ecap >> 58) & 1 )) "58" "$(printf '%01b' $(( (ecap >> 58) & 1 )))"
    printf "%-50s: %-10d Bits: %-5s Binary: %s\n" "RDT Configuration Support (RDTS)" $(( (ecap >> 60) & 1 )) "60" "$(printf '%01b' $(( (ecap >> 60) & 1 )))"
    printf "%-50s: %-10d Bits: %-5s Binary: %s\n" "Extended Interrupt Mode Enable Required (EIMER)" $(( (ecap >> 61) & 1 )) "61" "$(printf '%01b' $(( (ecap >> 61) & 1 )))"
    printf "%-50s: %-10d Bits: %-5s Binary: %s\n" "Interrupt Remapping Required (IRREQ)" $(( (ecap >> 62) & 1 )) "62" "$(printf '%01b' $(( (ecap >> 62) & 1 )))"
}

# Read the iommu_regset file
iommu_file="/sys/kernel/debug/iommu/intel/iommu_regset"
if [ ! -f "$iommu_file" ]; then
    echo "IOMMU regset file not found: $iommu_file"
    exit 1
fi

# Parse the file and decode CAP and ECAP
while IFS= read -r line; do
    if [[ $line =~ ^IOMMU:\ ([^[:space:]]+)\ Register\ Base\ Address:\ ([^[:space:]]+)$ ]]; then
        iommu=${BASH_REMATCH[1]}
        base_address=${BASH_REMATCH[2]}
        echo -e "\nIOMMU: $iommu Register Base Address: $base_address"
    elif [[ $line =~ ^CAP[[:space:]]+0x08[[:space:]]+(0x[0-9a-fA-F]+)$ ]]; then
        cap=${BASH_REMATCH[1]}
        echo -e "\nCAP: $cap"
        decode_cap $((cap))
        echo ""
    elif [[ $line =~ ^ECAP[[:space:]]+0x10[[:space:]]+(0x[0-9a-fA-F]+)$ ]]; then
        ecap=${BASH_REMATCH[1]}
        echo -e "\nECAP: $ecap"
        decode_ecap $((ecap))
        echo ""
    fi
done < "$iommu_file"

