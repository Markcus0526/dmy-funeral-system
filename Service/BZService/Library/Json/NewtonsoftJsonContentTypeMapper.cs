using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ServiceModel.Channels;

namespace BZService.Library.Json
{
	public class NewtonsoftJsonContentTypeMapper : WebContentTypeMapper
	{
		public override WebContentFormat GetMessageFormatForContentType(String contentType)
		{
			return WebContentFormat.Raw;
		}
	}
}