devices=PsychHID('devices');

if ~isempty(find(strcmp({devices.manufacturer},'Current Designs, Inc.') & strcmp({devices.usageName}, 'Keyboard'),1))
    resp_device=find(strcmp({devices.manufacturer},'Current Designs, Inc.') & strcmp({devices.usageName},'Keyboard'));
else
    resp_device=find(strcmp({devices.usageName},'Keyboard'));
    
end