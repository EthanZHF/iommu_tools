  #!/bin/bash

# Function to list the IOMMU tree
list_iommu_tree() {
    iommu_base_path="/sys/class/iommu"
    
    # Check if the IOMMU base path exists
    if [ ! -d "$iommu_base_path" ]; then
        echo "IOMMU base path not found. Ensure IOMMU is enabled."
        return
    fi
    
    # Iterate through each IOMMU instance
    for iommu in $(ls "$iommu_base_path"); do
        iommu_path="$iommu_base_path/$iommu"
        echo "IOMMU: $iommu"
        
        # Check for devices associated with the IOMMU instance
        devices_path="$iommu_path/devices"
        if [ -d "$devices_path" ]; then
            group_set=()
            for device in $(ls "$devices_path"); do
                device_path="$devices_path/$device"
                
                # Check for IOMMU group associated with the device
                iommu_group_path="$device_path/iommu_group"
                if [ -d "$iommu_group_path" ]; then
                    group_id=$(basename "$(readlink "$iommu_group_path")")
                    if [[ ! " ${group_set[@]} " =~ " ${group_id} " ]]; then
                        # Read reserved regions content
                        reserved_regions_path="$iommu_group_path/reserved_regions"
                        if [ -f "$reserved_regions_path" ]; then
                            reserved_regions_content=$(cat "$reserved_regions_path")
                            echo "  IOMMU Group: $group_id - Reserved Regions: $reserved_regions_content"
                        else
                            echo "  IOMMU Group: $group_id - Reserved Regions: None"
                        fi
                        group_set+=("$group_id")
                    fi
                    
                    # List devices in the current IOMMU group
                    group_devices_path="$iommu_group_path/devices"
                    if [ -d "$group_devices_path" ]; then
                        for group_device in $(ls "$group_devices_path"); do
                            # Get detailed information about the device using lspci
                            device_info=$(lspci -nn -s "$group_device")
			    formatted_device_info=$(echo "$device_info" | sed -E 's/^[0-9a-f]{2}:[0-9a-f]{2}\.[0-9] //')
                            echo "    Group Device: $group_device - $formatted_device_info"
                        done
                    fi
                fi
            done
        else
            echo "  No devices found for this IOMMU instance."
        fi
        echo ""
    done
}

# Run the function to list the IOMMU tree
list_iommu_tree

